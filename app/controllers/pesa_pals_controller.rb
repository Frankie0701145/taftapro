class PesaPalsController < ApplicationController

    def pesapal_payment
      @project = Project.find(params[:id])
      @request = Request.find(@project.request_id)
      if client_logged_in?

          pesapal = Pesapal::Merchant.new(:production)

          pesapal = Pesapal::Merchant.new(:development)

        @client = current_client
        pesapal.config = {
          callback_url:  pesapal_callback_url,
          consumer_key: ENV["PESAPAL_CONSUMER_KEY"],
          consumer_secret: ENV["PESAPAL_CONSUMER_SECRET"]
        }

        description = "Payment for project id #{@project.id}"
        pesapal.order_details = {
          amount: @project.debit_balance,
          description: description,
          type: 'MERCHANT',
          reference: @project.id,
          first_name: @client.first_name,
          last_name: @client.last_name,
          email: @client.email,
          phonenumber: @client.phone_number,
          currency: 'KES'
        }
        # generate transaction url
        @order_url = pesapal.generate_order_url
      end
    end

    def callback
      @pesapal_transaction_tracking_id = params[:pesapal_transaction_tracking_id]
      @pesapal_merchant_reference = params[:pesapal_merchant_reference]

      @project = Project.find_by(@pesapal_merchant_reference)
      if @project
        payment=Payment.new( pesapal_transaction_tracking_id: @pesapal_transaction_tracking_id, client_id: @project.client_id,
                        project_id: @project.id, professional_id: @project.professional_id, payment_type: "pesapal", amount: @project.debit_balance
                    )
        if payment.save
          flash[:success] = "You payment is being processed"
        end
      else
        flash[:danger] =  "Something went wrong, please contact us."
      end
      redirect_to projects_path
    end

    def ipn
      pesapal_notification_type = params[:pesapal_notification_type]
      pesapal_merchant_reference = params[:pesapal_merchant_reference]
      pesapal_transaction_tracking_id = params[:pesapal_transaction_tracking_id]
      pesapal = Pesapal::Merchant.new
      @response_to_ipn = pesapal.ipn_listener(pesapal_notification_type,
	                                           pesapal_merchant_reference,
	                                           pesapal_transaction_tracking_id)
      payment = Payment.where(:pesapal_merchant_reference => pesapal_merchant_reference,
                              :pesapal_transaction_tracking_id => pesapal_transaction_tracking_id).first
      case @response_to_ipn[:status]
      when "COMPLETED"
        project=Project.find(pesapal_merchant_reference)
        project.update( paid: project.debit_balance, debit_balance: 0, payment_type: "pesapal" )
        payment.update( pesapal_status: "COMPLETED")
      when "PENDING"
        payment.update( pesapal_status: "PENDING")
      when "FAILED"
        payment.update( pesapal_status: "FAILED")
      when "INVALID"
        payment.update( pesapal_status: "INVALID")
      end
    end

end
