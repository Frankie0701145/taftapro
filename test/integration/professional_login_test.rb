# frozen_string_literal: true

require 'test_helper'

class ProfessionalLoginTest < ActionDispatch::IntegrationTest
  test 'Login with Invalid credentials' do
    # get the professional login view
    get professional_login_path
    # confirm that the acquired view is the professional login view
    assert_response :success
    assert_template 'professional_sessions/new'
    # post the wrong login credentials
    post professional_login_path, params: { professional_session: { email: '', password: '' } }
    # confirm that the acquired view is the professional login view when the credentials are wrong
    assert_template 'professional_sessions/new'
    # confirm the the flash.message has a message
    assert_not flash.empty?
    # Confirm that the flash used is flash.now and does not show in the next request
    get root_path
    assert flash.empty?
  end
end
