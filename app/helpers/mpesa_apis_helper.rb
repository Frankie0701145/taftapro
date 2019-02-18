module MpesaApisHelper
  require 'net/http'
  require 'net/https'
  require 'uri'

  # method to request for outh access token
  def access_token
    uri = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
    #starting the persistant connection to the safaricom server
    NET::HTTP.start( uri.host, uri.port, :user_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
      request = Net::HTTP:Get.new uri.request_uri
      request.basic_auth "YOUR_APP_CONSUMER_KEY", "YOUR_APP_CONSUMER_SECRET"
      response = http.request request
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "******************THE RETURNED OBJECT FROM THE ACCETOKEN***************************************"
      puts response.body
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"
      puts "***********************************************************************************************"

    end
  end
  #method to register the confirmation and validation url
  def register_url
    uri = URI('https://sandbox.safaricom.co.ke/mpesa/b2b/v1/paymentrequest')
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri)
    request['accept'] = 'application/json'
    request['content-type'] ='application/json'
    request["authotization"] = 'Bearer <Access-token >'
    request.body = "{\"ShortCode\":\"ShortCode\",
    \"ResponseType\":\"ResponseType\",
    \"ConfirmationURL\":\"http://ip_address:port/confirmation\",
    \"ValidationURL\":\"http://ip_address:port/validation_url\"}"


  end
end
