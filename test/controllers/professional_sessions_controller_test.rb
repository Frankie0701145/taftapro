require 'test_helper'

class ProfessionalSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get professional_sessions_new_url
    assert_response :success
  end

end
