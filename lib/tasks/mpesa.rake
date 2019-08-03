require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class MpesaWrapper
    #method to go fetch the access token from mpesa api
    def self.generate_access_token consumer_key,consumer_secret, url
        uri = url
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https',
                        :verify_mode => OpenSSL::SSL::VERIFY_NONE
                      )do |http|
                        request = Net::HTTP::Get.new uri.request_uri
                          request.basic_auth consumer_key, consumer_secret
                          response = http.request request # Net::HTTPResponse object
                          if response.body.empty?
                            raise "Error!!!Make sure to provide the correct consumer key and consumer secret"
                          else
                            response.body
                          end
                    end
    end
    def self.register_confirmation_and_validation_url confirmation_url,validation_url,short_code, access_token, url

      uri = url

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

    def self.simulate_transaction url, access_token, short_code, amount, msisdn, ref
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request["authorization"] = "Bearer #{access_token}"
      request.body = "{\"ShortCode\":\"#{short_code}\",
              \"CommandID\":\"CustomerPayBillOnline\",
              \"Amount\":\"#{amount}\",
              \"Msisdn\":\"#{msisdn}\",
              \"BillRefNumber\":\" #{ref}\"}"
      response = http.request(request)
      puts response.read_body
    end
end



namespace :mpesa do

  namespace :production do
    desc "Registers the confirmation and validation url to mpesa api"
    task register_confirmation_and_validation_url: :environment do
      if !(Rails.application.credentials[:MPESA_CONSUMER_KEY]) || !(Rails.application.credentials[:MPESA_CONSUMER_SECRET])
        puts "Make sure to define the MPESA_CONSUMER_KEY and MPESA_CONSUMER_SECRET in the encrypt environment variables"
      elsif !(Rails.application.credentials[:MPESA_CONFIRMATION_URL]) || !(Rails.application.credentials[:MPESA_VALIDATION_URL])
        puts "Make sure to define the MPESA_VALIDATION_URL and MPESA_CONFIRMATION_URL in the encrypt environment variables"
      elsif !(Rails.application.credentials[:MPESA_SHORT_CODE])
        puts "Make sure to define the MPESA_SHORT_CODE in the encrypt environment variables"
      else
        URL_accesstoken = URI('https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
        URL_register =  URI('https://api.safaricom.co.ke/mpesa/c2b/v1/registerurl')
        Consumer_key = Rails.application.credentials[:MPESA_CONSUMER_KEY]
        Consumer_secret = Rails.application.credentials[:MPESA_CONSUMER_SECRET]
        Confirmation_url = Rails.application.credentials[:MPESA_CONFIRMATION_URL]
        Validation_url = Rails.application.credentials[:MPESA_VALIDATION_URL]
        Short_code = Rails.application.credentials[:MPESA_SHORT_CODE]
        puts "Validation url: #{Validation_url}", "Confirmation url: #{Confirmation_url}"
        puts "consumer_key:#{Consumer_key} consumer_secret: #{Consumer_secret}"
        response_body = MpesaWrapper.generate_access_token(Consumer_key, Consumer_secret, URL_accesstoken)
        puts response_body
        hashed_response_body = JSON.parse response_body
        puts hashed_response_body
        Access_token = hashed_response_body["access_token"]
        MpesaWrapper.register_confirmation_and_validation_url Confirmation_url,Validation_url,Short_code, Access_token, URL_register
      end
    end
  end

  namespace :development do
    desc "Testing mpesa api call"
    URL_dev_accesstoken = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
    Consumer_dev_key = Rails.application.credentials[:TEST_MPESA_CONSUMER_KEY]
    Consumer_dev_secret = Rails.application.credentials[:TEST_MPESA_CONSUMER_SECRET]
    Short_dev_code = ENV["SHORT_CODE"]


    task register_confirmation_and_validation_url: :environment do
      if !(ENV["CONF_URL"]) || !(ENV["VAL_URL"])
        puts "Please parse the CONF_URL and VAL_URL"
      elsif !(Short_dev_code)
        puts "Please parse the SHORT_CODE"
      elsif !(Consumer_dev_key) || !(Consumer_dev_secret)
        puts "Make sure to define the TEST_MPESA_CONSUMER_KEY and TEST_MPESA_CONSUMER_SECRET in the encrypt environment variables"
      else
        URL_dev_register =  URI('https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl')
        Confirmation_dev_url = ENV["CONF_URL"]
        Validation_dev_url = ENV["VAL_URL"]
        puts Consumer_dev_key, Consumer_dev_secret, Validation_dev_url, Short_dev_code
        response_body = MpesaWrapper.generate_access_token(Consumer_dev_key, Consumer_dev_secret, URL_dev_accesstoken)
        puts response_body
        hashed_response_body = JSON.parse response_body
        Access_dev_token = hashed_response_body["access_token"]
        MpesaWrapper.register_confirmation_and_validation_url Confirmation_dev_url,Validation_dev_url,Short_dev_code, Access_dev_token, URL_dev_register
      end
    end


    task simulate_transaction: :environment do
      Uri_dev_simulate = URI('https://sandbox.safaricom.co.ke/mpesa/c2b/v1/simulate')
      if !(Short_dev_code) || !(ENV["AMOUNT"])
        puts "Please parse the SHORT_CODE and AMOUNT as environment variable"
      elsif !(ENV["MSISDN"]) || !(ENV["REF"])
        puts "Please parse in the MSISDN and the REF as environment variable"
      else
        response_body = MpesaWrapper.generate_access_token(Consumer_dev_key, Consumer_dev_secret, URL_dev_accesstoken)
        hashed_response_body = JSON.parse response_body
        Access_dev_token = hashed_response_body["access_token"]
        puts response_body
        Amount = ENV["AMOUNT"]
        Msisdn = ENV["MSISDN"]
        Ref = ENV["REF"]
        MpesaWrapper.simulate_transaction Uri_dev_simulate, Access_dev_token, Short_dev_code, Amount, Msisdn, Ref
      end

    end

  end
end
