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
    @greeting = "Hi, #{@client.first_name}"

    mail to: @client.email, subject:"Password Reset"
  end

  def quotation(client, professional: professional, request: request, answers:answers)
    @client = client
    @professional = professional
    @request = request
    @answers = answers
    @greeting = "Hi, #{@professional.first_name}"

    mail to: @professional.email, subject: "Potential Client"
  end

  def password_send(client,password)
    @client = client
    @password = password
    @greeting = "Hi, #{@client.first_name}"
    mail to: @client.email, subject: "Sending Password"
  end
end
