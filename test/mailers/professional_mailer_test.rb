require 'test_helper'

class ProfessionalMailerTest < ActionMailer::TestCase
  test "password_reset" do
    mail = ProfessionalMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
