require 'test_helper'

class MpesaApisControllerTest < ActionDispatch::IntegrationTest

    #confirmation endpoint
    # test "should get the ok response from the confirmation url with correct password" do
    #   accesstoken_query_string = {
    #     access_token: Rails.application.credentials.MPESA_SECRET
    #   }
    #   post mpesa_confirmation_callback_path(accesstoken_query_string)
    #   assert_response :success
    # end

    test "should get bad request from the confirmation url with wrong password" do
      accesstoken_query_string = {
        access_token: "uiujigg"
      }
      post mpesa_confirmation_callback_path(accesstoken_query_string)
      assert_response :bad_request
    end

    #validation endpoint
    # test "should get the ok response from the validation url with correct password" do
    #   accesstoken_query_string = {
    #     access_token: Rails.application.credentials.MPESA_SECRET
    #   }
    #   post mpesa_validation_callback_path(accesstoken_query_string)
    #   assert_response :success
    # end

    test "should get bad request from the validation url with wrong password" do
      accesstoken_query_string = {
        access_token: "uiujigg"
      }
      post mpesa_validation_callback_path(accesstoken_query_string)
      assert_response :bad_request
    end



end
