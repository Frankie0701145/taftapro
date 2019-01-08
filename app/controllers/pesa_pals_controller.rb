class PesaPalsController < ApplicationController

    def pesapal_payment
      @project = Project.find(params[:id])
      @request = Request.find(@project.request_id)
      if client_logged_in?
        # if Rails.env.production?
        #   pesapal = Pesapal::Merchant.new(:production)
        # else
          pesapal = Pesapal::Merchant.new(:development)
        # end

        @client = current_client
        pesapal.config = {
          callback_url:  ENV["PESAPAL_CALLBACK_URL"],
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
      puts "**************************************************"
      puts "***********  PESAPAL CALLBACK *******************"
      puts "**************************************************"
      
      @pesapal_transaction_tracking_id = params[:pesapal_transaction_tracking_id]
      @pesapal_merchant_reference = params[:pesapal_merchant_reference]

      @project = Project.find(@pesapal_merchant_reference)
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

      puts "*** Beginning of debug block ***" 
        # pesapal_notification_type = params[:pesapal_notification_type]
        # pesapal_merchant_reference = params[:pesapal_merchant_reference]
        # pesapal_transaction_tracking_id = params[:pesapal_transaction_tracking_id]

        # pesapal = Pesapal::Merchant.new(:development)

        # @response_to_ipn = pesapal.ipn_listener(pesapal_notification_type, pesapal_merchant_reference, pesapal_transaction_tracking_id).with_indifferent_access
        
        # if @response_to_ipn
        #  puts "*********RESPONSE TO IPN  STATUS: #{@response_to_ipn[:status]} ******"        
        # else
        #   puts " NO RESP TO IPN "
        # end

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
    
      # if Rails.env.production?
      #   pesapal = Pesapal::Merchant.new(:production)
      # else
        pesapal = Pesapal::Merchant.new(:development)
      # end
      
      pesapal.config = {
        callback_url:  ENV["PESAPAL_CALLBACK_URL"],
        consumer_key: ENV["PESAPAL_CONSUMER_KEY"],
        consumer_secret: ENV["PESAPAL_CONSUMER_SECRET"]
      }      
      
      @response_to_ipn = pesapal.ipn_listener(pesapal_notification_type, pesapal_merchant_reference, pesapal_transaction_tracking_id).with_indifferent_access
      
      if @response_to_ipn[:status] == "PENDING"
        puts "*********RESPONSE TO IPN  STATUS ******"

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
      else
        puts " NO RESP TO IPN "
      end


      render :text => @response_to_ipn
    end

end
