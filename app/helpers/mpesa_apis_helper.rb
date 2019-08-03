module MpesaApisHelper

    def correct_password?(access_token)
      hash = Rails.application.credentials.MPESA_SECRET_HASH
      result = (BCrypt::Password.new hash) == access_token
      return result
    end
end
