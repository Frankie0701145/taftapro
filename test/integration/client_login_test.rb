# frozen_string_literal: true

require 'test_helper'

class ClientLoginTest < ActionDispatch::IntegrationTest
  test 'Login with Invalid credentials' do
    # get the client login view
    get client_login_path
    # confirm that the acquired view is the client login view
    assert_response :success
    assert_template 'client_sessions/new'
    # post the wrong login credentials
    post client_login_path, params: { client_session: { email: '', password: '' } }
    # confirm that the acquired view is the client login view when the credentials are wrong
    assert_template 'client_sessions/new'
    # confirm the the flash.message has a message
    assert_not flash.empty?
    # Confirm that the flash used is flash.now and does not show in the next request
    get root_path
    assert flash.empty?
  end
end
