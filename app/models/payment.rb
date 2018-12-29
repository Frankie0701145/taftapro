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
#  pesapal_transaction_tracking_id :integer
#  professional_id                 :integer
#  project_id                      :integer
#

class Payment < ApplicationRecord

  def check_status
    # if self.status == Payment.status_pending
      if Rails.env.production?
      	pesapal = Pesapal::Merchant.new(:production)
      else
      	pesapal = Pesapal::Merchant.new(:development)
      end

      # project_id == pesapal_merchant_reference

      payment_status = pesapal.query_payment_status(self.project_id, self.pesapal_transaction_tracking_id)
      puts "THIS IS THE PAYMENT STATUS #{payment_status}"
      #payment_status can be either PENDING, COMPLETED, FAILED or INVALID
      if payment_status
        if payment_status.downcase == 'pending'
          self.status = Payment.status_pending
        elsif payment_status.downcase == 'completed'
          self.status = Payment.status_completed
        elsif payment_status.downcase == 'failed'
          self.status = Payment.status_failed
        elsif payment_status.downcase == 'invalid'
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
	    else
			puts "**************************************************"
	        puts "*********** WITHIN SAVE BLOCK BUT STATUS IS NOT COMPLETED *******************"
	        puts "**************************************************" 

        end
      else
		puts "**************************************************"
        puts "*********** SITASEV!!! *******************"
        puts "**************************************************"       	
      end
    # end
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
