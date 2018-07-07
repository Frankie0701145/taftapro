require 'test_helper'

class ProfessionalPasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @professional = Professional.new(first_name: "John", last_name: "Doe", email: "johndoe2@gmail.com",
                                     password: "foobar", password_confirmation: "foobar",service: "plumbing",
                                     city:"Nakuru", country:"Kenya")
    @professional.save
  end

  test "professional password test" do

    #get the the view to place the email that will be sent the reset link
    get new_professional_password_reset_path
    #Confirm that the render view is the view to enter the email that will be sent the reset email
    assert_template "professional_password_resets/new"
    #Invalid Email. We are to send invalid email and check to see
    #we post the invalid email
    post professional_password_resets_path, params: {professional_password_reset: { email: ""}}
    #we confirm that the flash message is not empty
    assert_not flash.empty?
    #we confrim that we are redirceted back to view for entering the email to send the password reset
    assert_template "professional_password_resets/new"

    #valid email
    #we post with a valid email
    post professional_password_resets_path,
         params: {professional_password_reset: { email: @professional.email}}

    assert_not_equal @professional.reset_digest, @professional.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    #Password reset form
    #gets the current professional identified by the email
    professional=assigns(:professional)
    #Wrong Email
    get edit_professional_password_reset_path(professional.reset_token, email: "")
    assert_redirected_to root_url
    #Right email, wrong token
    get edit_professional_password_reset_path('wrong token', email: professional.email)
    assert_redirected_to root_url
    #Right email, right token
    get edit_professional_password_reset_path(professional.reset_token, email: professional.email)
    assert_template "professional_password_resets/edit"
    assert_select "input[name=email][type=hidden][value=?]", professional.email
    #Invalid password & confirmation
    patch professional_password_reset_path(professional.reset_token),
          params: {email: professional.email,
                   professional:{ password: "foobaz",
                   password_confirmation: "barquux"}}
    assert_select "div#error_explanation"
    #empty password
    patch professional_password_reset_path(professional.reset_token),
          params: { email:professional.email,
                    professional:{ password:"",
                    password_confirmation:""}}
    assert_select 'div#error_explanation'
    #Valid password & confirmation
    patch professional_password_reset_path(professional.reset_token),
          params: { email: professional.email,
                    professional:{ password:"foobaz",
                    password_confirmation:"foobaz"}}
    assert professional_is_logged_in?
    assert_not flash.empty?
    assert_redirected_to professional
  end
end
