require 'test_helper'

class ClientMailerTest < ActionMailer::TestCase

=begin
  test "account_activation" do
    mail = ClientMailer.account_activation
    assert_equal "Account activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
=end
def setup
  @client = Client.new(first_name: "John", last_name: "Doe", email: "johndoe@gmail.com",
            password: "foobar", password_confirmation: "foobar")
end

  test "Client password_reset" do

    @client.reset_token = Client.new_token
    mail = ClientMailer.password_reset( @client)
    assert_equal "Password Reset", mail.subject
    assert_equal [@client.email], mail.to
    assert_equal ["noreply@taftapro.com"], mail.from
    assert_match @client.reset_token,   mail.body.encoded
    assert_match CGI.escape(@client.email), mail.body.encoded
  end


end
