class MpesaApisController < ApplicationController
    include MpesaApisHelper
  #skipped the csrf in this controller
  skip_before_action :verify_authenticity_token, only: %i[validation_callback confirmation_callback]

  def mpesa_payment
    @project_id = params[:id]
    @shortcode = Rails.application.credentials[:MPESA_SHORT_CODE]
    @project_debit_balance = Project.where( id: @project_id).pluck(:debit_balance)[0]

  end

  #endpoint to validate the mpesa transaction
  def validation_callback
    result = check_password params[:access_token]
    puts "****************************************************"
    puts "****************************************************"
    puts "*********Validation Callback************************"
    puts "****************************************************"
    puts "****************************************************"
    if result
      #first check to see if there is a project with that project id which is the BillRefNumber
      project = Project.find_by(id: params[:BillRefNumber])
      #if there is a project with that project id(BillRefNumber) accept the payement
      if project
        # found the project
        response_json = {:ResultCode => 0, :ResultDesc=> "Accepted" }
        render json: response_json
      # if there is no project with that project id (BillRefNumber) decline the payment
      else
        response_json = {:ResultCode=>1, :ResultDesc=>"Rejected"}
        render json: response_json
      end
    else
      render json: {"Error":"Bad Request"}, :status => :bad_request
    end
  end

  #the confirmation_callback handler
  def confirmation_callback
      result = check_password params[:access_token]
      project = Project.find_by(id: params[:BillRefNumber])
      puts "**************************************************"
      puts "**************************************************"
      puts "*********Confirmation Callback**********************"
      puts "**************************************************"
      puts "**************************************************"
      #check it the call is really coming from mpesa daraja
      if result

        #creates new payment
        payment = Payment.new(trans_id: params[:TransID], client_id: project.client_id,
          project_id: project.id, professional_id: project.professional_id, payment_type: "mpesa",
          amount: params[:TransAmount], msisdn:params[:MSISDN],
          mpesa_status: "completed", status: Payment.status_completed,
          trans_time: params[:TransTime]
        )
        #saves the payment
        if payment.save
          #updates the project paid amount and debit balance
          project_debit_balance = project.debit_balance - payment.amount
          project_paid = project.paid + payment.amount
          project.update_attributes(paid: project_paid , debit_balance: project_debit_balance)
          response_json = { C2BPaymentConfirmationResult: "Success" }
          render json: response_json
        end
      else
        render json: {"Error":"Bad Request"}, :status => :bad_request
      end
  end

  private
    def check_password access_token
      begin
        result = correct_password?(access_token)
        return result
      rescue
        render json: {"Error":"Bad Request"}, :status => :bad_request
      end
    end
end
