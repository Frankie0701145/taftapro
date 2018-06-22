require 'test_helper'

class ProfessionalsControllerTest < ActionDispatch::IntegrationTest
  # test "should get new" do
  #   get professionals_new_url
  #   assert_response :success
  # end

  # test "should get index" do
  #   get professionals_index_url
  #   assert_response :success
  # end

  # test "should get show" do
  #   get professionals_show_url
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get professionals_edit_url
  #   assert_response :success
  # end

  test "should get the professional signup page" do
    get professional_signup_url
    #check to see if the returned template is the professional signup view
    assert_template 'professionals/new'
  end

end
