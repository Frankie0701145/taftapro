# frozen_string_literal: true

require 'test_helper'

class ClientPasswordResetsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    ActionMailer::Base.deliveries.clear
    @client = Client.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@gmail.com',
                         password: 'foobar', password_confirmation: 'foobar')
    @client.save
  end

  test 'password resets' do
    # get the the view to place the email that will be sent the reset link
    get new_client_password_reset_path
    # Confirm that the render view is the view to enter the email that will be sent the reset email
    assert_template 'client_password_resets/new'

    # Invalid Email. We are to send invalid email and check to see
    # we post the invalid email
    post client_password_resets_path, params: { client_password_reset: { email: '' } }
    # we confirm that the flash.empty is not empty
    assert_not flash.empty?
    # we confrim that the template with is the view tp enter the email to send the password reset
    assert_template 'client_password_resets/new'

    # valid email
    # we post with a valid email
    post client_password_resets_path,
         params: { client_password_reset: { email: @client.email } }

    assert_not_equal @client.reset_digest, @client.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    client = assigns(:client)
    # Wrong email
    get edit_client_password_reset_path(client.reset_token, email: '')
    assert_redirected_to root_url
    # Right email, wrong token
    get edit_client_password_reset_path('wrong token', email: client.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_client_password_reset_path(client.reset_token, email: client.email)
    assert_template 'client_password_resets/edit'
    assert_select 'input[name=email][type=hidden][value=?]', client.email
    # Invalid password & confirmation
    patch client_password_reset_path(client.reset_token),
          params: { email: client.email,
                    client: { password: 'foobaz',
                              password_confirmation: 'barquux' } }
    assert_select 'div#error_explanation'
    # Empty password
    patch client_password_reset_path(client.reset_token),
          params: { email: client.email,
                    client: { password: '',
                              password_confirmation: '' } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch client_password_reset_path(client.reset_token),
          params: { email: client.email,
                    client: { password: 'foobaz',
                              password_confirmation: 'foobaz' } }

    assert client_is_logged_in?
    assert_not flash.empty?
    assert_redirected_to client
  end
end
