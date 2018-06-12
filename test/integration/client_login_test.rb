require 'test_helper'

class ClientLoginTest < ActionDispatch::IntegrationTest

  test "Login with Invalid credentials" do
    #get the client login view
    get client_login_path
    #confirm that the acquired view is the client login view
    assert_response :success
    #post the wrong login credentials
    post client_login_path, params:{client_session:{email:"",password:""}}

    #confirm that the acquired view is the client login view when the credentials are wrong
    assert_response :success

    #confirm the the flash.message has a message
    assert_not flash.empty?

  end

end
