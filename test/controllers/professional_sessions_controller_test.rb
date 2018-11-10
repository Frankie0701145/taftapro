# frozen_string_literal: true

require "test_helper"

class ProfessionalSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get professional_login_path
    assert_response :success
  end
end
