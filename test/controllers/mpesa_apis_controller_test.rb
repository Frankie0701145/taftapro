require 'test_helper'

class MpesaApisControllerTest < ActionDispatch::IntegrationTest

    #confirmation endpoint
    # test "should get the ok response from the confirmation endPoint with correct password" do
    #   accesstoken_query_string = {
    #     access_token: Rails.application.credentials.MPESA_SECRET
    #   }
    #   post mpesa_confirmation_callback_path(accesstoken_query_string)
    #   assert_response :success
    # end

    test "should get bad request from the confirmation endPoint with wrong access_token" do
      accesstoken_query_string = {
        access_token: "uiujigg"
      }
      post mpesa_confirmation_callback_path(accesstoken_query_string)
      assert_response :bad_request
    end
    test "should get bad request from the confirmation endPoint if access_token is not provided" do
      post mpesa_confirmation_callback_path()
      assert_response :bad_request
    end

    #validation endpoint
    # test "should get the ok response from the validation endPoint with correct password" do
    #   accesstoken_query_string = {
    #     access_token: Rails.application.credentials.MPESA_SECRET
    #   }
    #   post mpesa_validation_callback_path(accesstoken_query_string)
    #   assert_response :success
    # end

    test "should get bad request from the validation endPoint with wrong access_token" do
      accesstoken_query_string = {
        access_token: "uiujigg"
      }
      post mpesa_validation_callback_path(accesstoken_query_string)
      assert_response :bad_request
    end
    test "should get bad request from the validation endPoint if access_token is not provided" do
      post mpesa_validation_callback_path()
      assert_response :bad_request
    end


end
