# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/client_mailer/account_activation
  def account_activation
    ClientMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/client_mailer/password_reset
  def password_reset
  	client = Client.first
  	client.reset_token = Client.new_token
    ClientMailer.password_reset(client)
  end

  def quotation
    client = Client.first
    professional = Professional.last
    request = Request.last
    ClientMailer.quotation(client, professional: professional, request: request)
  end  

end
