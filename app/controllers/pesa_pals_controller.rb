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
          consumer_key: "vOa5kQBEVNBWCaSodnls0KEyrzW4s7tC",
          consumer_secret: "LXz0HnCxNMZ/KdkxhLkrgKbwkHE="
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
                      project_id: @project.id, professional_id: @project_id
                    )
        if payment.save
          flash[:success] = "You payment is being processed"
        end
      else
        flash[:danger] =  "Something went wrong, please contact us."
      end
      redirect_to projects_path
    end

end
