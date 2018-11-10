# frozen_string_literal: true

require 'test_helper'

class ClientSessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get client_login_path
    assert_response :success
  end
end
