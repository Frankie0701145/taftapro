class MpesaApisController < ApplicationController
  #skipped the csrf in this controller
  skip_before_action :verify_authenticity_token
  def mpesa_payment
    @project_id = params[:id]
    @shortcode = Rails.application.credentials[:MPESA_SHORT_CODE]
    @project_debit_balance = Project.where( id: @project_id).pluck(:debit_balance)[0]

  end
  #endpoint to validate the mpesa transaction
  def validation_callback
    #first check to see if there is a project with that project id which is the BillRefNumber
    project = Project.find_by(id: params[:BillRefNumber])
    #if there is a project with that project id(BillRefNumber) accept the payement
    if project
      # found the project
      payment = Payment.new(trans_id: params[:TransID], client_id: project.client_id,
        project_id: project.id, professional_id: project.professional_id, payment_type: "mpesa",
        amount: params[:TransAmount], msisdn:params[:MSISDN],
        mpesa_status: "pending", status: Payment.status_pending
      )
      if payment.save
        response_json = {:ResultCode => 0, :ResultDesc=> "Accepted" }
        render json: response_json
      end
    # if there is no project with that project id (BillRefNumber) decline the payment
    else
      response_json = {:ResultCode=>1, :ResultDesc=>"Rejected"}
      render json: response_json
    end
  end

  #the confirmation_callback handler
  def confirmation_callback
    payment = Payment.where(trans_id: params[:TransID], project_id: params[:BillRefNumber]).first
    if payment
      payment.update_attributes(status:  Payment.status_completed, mpesa_status: "completed", trans_time: params[:TransTime])
      project = Project.find_by(id: params[:BillRefNumber])
      if project
        project_debit_balance = project.debit_balance - payment.amount
        project_paid = project.paid + payment.amount
        project.update_attributes(paid: project_paid , debit_balance: project_debit_balance)
        response_json = { C2BPaymentConfirmationResult: "Success" }
        render json: response_json
      end
    end
  end
end
