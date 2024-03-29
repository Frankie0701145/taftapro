class PesaPalsController < ApplicationController

    def pesapal_payment
      @project = Project.find(params[:id])
      @request = Request.find(@project.request_id)
      if client_logged_in?
        if Rails.env.production?
          pesapal = Pesapal::Merchant.new(:production)
        else
          pesapal = Pesapal::Merchant.new(:development)
        end

        @client = current_client
        pesapal.config = {
          callback_url: Rails.application.credentials[:PESAPAL_CALLBACK_URL],
          consumer_key: Rails.application.credentials[:PESAPAL_CONSUMER_KEY],
          consumer_secret: Rails.application.credentials[:PESAPAL_CONSUMER_SECRET]
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
      puts "**************************************************"
      puts "***********  PESAPAL CALLBACK *******************"
      puts "**************************************************"

      @pesapal_transaction_tracking_id = params[:pesapal_transaction_tracking_id]
      @pesapal_merchant_reference = params[:pesapal_merchant_reference]

      @project = Project.find_by(id: @pesapal_merchant_reference)
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

        payment = Payment.where(:project_id => @pesapal_merchant_reference,
                                :pesapal_transaction_tracking_id => @pesapal_transaction_tracking_id).first
        if payment
          payment.check_status
        else
          puts "**************************************************"
          puts "***********  {PROBABLY USELESS} NO PAYMENT DETECTED *******************"
          puts "**************************************************"
        end
      puts "*** END of debug block ***"

      redirect_to projects_path
    end

    def ipn
      puts "**************************************************"
      puts "***********  PESAPAL IPN LISTENER *************"
      puts "**************************************************"

      pesapal_notification_type = params[:pesapal_notification_type]
      pesapal_merchant_reference = params[:pesapal_merchant_reference]
      pesapal_transaction_tracking_id = params[:pesapal_transaction_tracking_id]

      if Rails.env.production?
        pesapal = Pesapal::Merchant.new(:production)
      else
        pesapal = Pesapal::Merchant.new(:development)
      end

      pesapal.config = {
        callback_url: Rails.application.credentials[:PESAPAL_CALLBACK_URL],
        consumer_key: Rails.application.credentials[:PESAPAL_CONSUMER_KEY],
        consumer_secret: Rails.application.credentials[:PESAPAL_CONSUMER_SECRET]

      }

      @response_to_ipn = pesapal.ipn_listener(pesapal_notification_type, pesapal_merchant_reference, pesapal_transaction_tracking_id).with_indifferent_access


      if @response_to_ipn[:status] == "PENDING"
        puts "*********RESPONSE TO IPN =>  STATUS is PENDING ******"

        payment = Payment.where(:project_id => pesapal_merchant_reference,
                                  :pesapal_transaction_tracking_id => pesapal_transaction_tracking_id).first
        if payment
          payment.update_attribute(:status, Payment.status_pending)
          payment.check_status
        else
          puts "**************************************************"
          puts "*********** PAYMENT NOT FOUND *******************"
          puts "**************************************************"
        end
      elsif @response_to_ipn[:status] == "COMPLETED"
        puts "*********RESPONSE TO IPN =>  STATUS is COMPLETED ******"

        payment = Payment.where(:project_id => pesapal_merchant_reference,
                                  :pesapal_transaction_tracking_id => pesapal_transaction_tracking_id).first
        payment.update_attribute(:status, Payment.status_completed)

        #Status was pending and is now completed

        project = Project.find(payment.project_id)
        project.update_attribute(:paid, payment.amount)

        project_bal = payment.amount - project.paid

        project.update_attributes(paid: project.paid, debit_balance: project_bal)
      end


      render :text => @response_to_ipn
    end

end
