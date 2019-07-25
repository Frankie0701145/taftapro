require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class MpesaWrapper
    #method to go fetch the access token from mpesa api
    def generate_access_token consumer_key,consumer_secret
        uri = URI('https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https',
                        :verify_mode => OpenSSL::SSL::VERIFY_NONE
                      )do |http|
                        request = Net::HTTP::Get.new uri.request_uri
                          request.basic_auth consumer_key, consumer_secret
                          response = http.request request # Net::HTTPResponse object
                          if response.body.empty?
                            raise "Error!!!Make sure to provide the correct access token and access secret"
                          else
                            response.body
                          end
                    end
    end
    def register_confirmation_and_validation_url confirmation_url,validation_url,short_code, access_token

      uri = URI('https://api.safaricom.co.ke/mpesa/c2b/v1/registerurl')

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request["authorization"] = "Bearer #{access_token}"
      request.body = "{\"ShortCode\":\"#{short_code}\",
          \"ResponseType\":\"Cancelled\",
          \"ConfirmationURL\":\"#{confirmation_url}\",
          \"ValidationURL\":\"#{validation_url}\"}"

      response = http.request(request)
      puts response.read_body
    end
end



namespace :mpesa do
  desc "Registers the confirmation and validation url to mpesa api"
  task register_confirmation_and_validation_url: :environment do
    if Rails.application.credentials[:MPESA_CONSUMER_KEY].empty? || Rails.application.credentials[:MPESA_CONSUMER_SECRET].empty?
      puts "Make sure to define the MPESA_CONSUMER_KEY and MPESA_CONSUMER_SECRET in the encrypt environment variables"
    elsif Rails.application.credentials[:MPESA_CONFIRMATION_URL].empty? || Rails.application.credentials[:MPESA_VALIDATION_URL].empty?
      puts "Make sure to define the MPESA_VALIDATION_URL and MPESA_CONFIRMATION_URL in the encrypt environment variables"
    elsif Rails.application.credentials[:MPESA_SHORT_CODE].to_s.empty?
      puts "Make sure to define the MPESA_SHORT_CODE in the encrypt environment variables"
    else
      Consumer_key = Rails.application.credentials[:MPESA_CONSUMER_KEY]
      Consumer_secret = Rails.application.credentials[:MPESA_CONSUMER_SECRET]
      Confirmation_url = Rails.application.credentials[:MPESA_CONFIRMATION_URL]
      Validation_url = Rails.application.credentials[:MPESA_VALIDATION_URL]
      Short_code = Rails.application.credentials[:MPESA_SHORT_CODE]
      puts "consumer_key:#{Consumer_key} consumer_secret: #{Consumer_secret}"
      mpesa_wrapper = MpesaWrapper.new()
      response_body = mpesa_wrapper.generate_access_token(Consumer_key, Consumer_secret)
      puts response_body
      hashed_response_body = JSON.parse response_body
      puts hashed_response_body
      Access_token = hashed_response_body["access_token"]
      mpesa_wrapper.register_confirmation_and_validation_url Confirmation_url,Validation_url,Short_code, Access_token
    end
  end
end
