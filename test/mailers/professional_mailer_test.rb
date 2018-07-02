require 'test_helper'

class ProfessionalMailerTest < ActionMailer::TestCase

  def setup
    @professional = Professional.new(first_name: "John", last_name: "Doe", email: "johndoe@gmail.com",
              password: "foobar", password_confirmation: "foobar")
  end

  test "Professional password_reset" do
    @professional.reset_token = Professional.new_token
    mail = ProfessionalMailer.password_reset( @professional)
    assert_equal "Password Reset", mail.subject
    assert_equal [@professional.email], mail.to
    assert_equal ["noreply@taftapro.com"], mail.from
    assert_match @professional.reset_token,   mail.body.encoded
    assert_match CGI.escape(@professional.email), mail.body.encoded

  end

end
