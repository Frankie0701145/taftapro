require 'test_helper'

class ClientPasswordResetsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @client = Client.new(first_name: "John", last_name: "Doe", email: "johndoe@gmail.com",
              password: "foobar", password_confirmation: "foobar")
  end

  test "password resets" do
    #get the the view to place the email that will be sent the reset link
    get new_client_password_reset_path
    #Confirm that the render view is the view to enter the email that will be sent the reset email
    assert_template "client_password_resets#new"

    #Invalid Email. We are to send invalid email and check to see
    #we post the invalid email
    post client_password_resets_path, params: {client_password_reset: { email: ""}}
    #we confirm that the flash.empty is not empty
    assert_not flash.empty?
    #we confrim that the template with is the view tp enter the email to send the password reset
    assert_template "client_password_resets#new"

    #valid email
    #we post with a valid email
    #post client_password_resets_path, params: {client_password_reset: { email: @client.email }

  end

end
