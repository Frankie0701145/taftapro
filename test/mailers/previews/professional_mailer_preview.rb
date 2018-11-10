# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/professional_mailer
class ProfessionalMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/professional_mailer/password_reset
  def password_reset
    professional = Professional.first
    professional.reset_token = Professional.new_token
    ProfessionalMailer.password_reset(professional)
  end
end
