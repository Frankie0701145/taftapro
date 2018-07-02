# Preview all emails at http://localhost:3000/rails/mailers/professional_mailer
class ProfessionalMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/professional_mailer/password_reset
  def password_reset
    ProfessionalMailer.password_reset
  end

end
