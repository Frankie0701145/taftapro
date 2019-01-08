# == Schema Information
#
# Table name: payments
#
#  id                              :integer          not null, primary key
#  amount                          :decimal(10, 2)
#  payment_type                    :string
#  status                          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  client_id                       :integer
#  pesapal_transaction_tracking_id :string
#  professional_id                 :integer
#  project_id                      :integer
#

class Payment < ApplicationRecord

  def check_status
    if self.status == Payment.status_pending
      # if Rails.env.production?
      # 	pesapal = Pesapal::Merchant.new(:production)
      # else
      	pesapal = Pesapal::Merchant.new(:development)
      # end

      pesapal.config = {
          callback_url:  ENV["PESAPAL_CALLBACK_URL"],
          consumer_key: ENV["PESAPAL_CONSUMER_KEY"],
          consumer_secret: ENV["PESAPAL_CONSUMER_SECRET"]
        }
      # project_id == pesapal_merchant_reference

      payment_status = pesapal.query_payment_details(self.project_id, self.pesapal_transaction_tracking_id).with_indifferent_access
      if payment_status 
        puts "THIS IS THE PAYMENT STATUS #{payment_status["status"]}"
      else

        puts "NO PAYMENT STATUS FOUND"
      end
      #payment_status can be either PENDING, COMPLETED, FAILED or INVALID
      if payment_status
        if payment_status[:status] == 'PENDING'
          self.status = Payment.status_pending
        elsif payment_status[:status] == 'COMPLETED'
          self.status = Payment.status_completed
        elsif payment_status[:status] == 'FAILED'
          self.status = Payment.status_failed
        elsif payment_status[:status] == 'INVALID'
          self.status = Payment.status_invalid
        end
      end

      if self.save
        if self.status == Payment.status_completed
          #Status was pending and is now completed

	        project = Project.find(self.project_id)
	        project_bal = project.debit_balance
	        project.update_attributes(paid: project_bal, debit_balance: 0)
			    puts "**************************************************"
	        puts "*********** WITHIN SAVE BLOCK IT WORKED !!!! *******************"
	        puts "**************************************************" 
	      elsif self.status == Payment.status_pending
          # Handle partial payments
          # paid_amount = self.amount
          # if paid_amount > 0
          #   project = Project.find(self.project_id)
          #   payments = Payment.where(project_id: self.project_id)
          #   payments.each do |payment|

          #   end
          #   project_bal = project.debit_balance - paid_amount
          #   project.update_attributes(paid: project_bal, debit_balance: 0)

          # end
        else
			    puts "**************************************************"
	        puts "*********** WITHIN SAVE BLOCK BUT STATUS IS NOT COMPLETED *******************"
	        puts "**************************************************" 
        end
      else
		    puts "**************************************************"
        puts "*********** UNABLE TO SAVE *******************"
        puts "**************************************************"       	
      end
    end
    self.status
  end

  def self.status_pending
    0
  end

  def self.status_completed
    1
  end

  def self.status_failed
    2
  end

  def self.status_invalid
    3
  end

end
