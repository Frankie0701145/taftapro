class ClientMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_mailer.account_activation.subject
  #
  def account_activation(client)
    @greeting = "Hi"
    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_mailer.password_reset.subject
  #
  def password_reset(client)
    @client=client
    @greeting = "Hi, #{client.first_name}"

    mail to: client.email, subject:"Password Reset"
  end

  def quotation(client, professional: professional)
    @client = client
    @professional = professional
    @greeting = "Hi, #{client.first_name}"

    mail to: client.email, subject: "Your Quotation Request"    
  end
end
