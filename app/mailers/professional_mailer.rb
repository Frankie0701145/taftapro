# frozen_string_literal: true

class ProfessionalMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.professional_mailer.password_reset.subject
  #

  # password reset method for the professional mailer
  def password_reset(professional)
    @professional = professional
    @greeting = "Hi, #{@professional.first_name}"

    mail to: @professional.email, subject: 'Password Reset'
  end
end
