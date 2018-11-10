# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "noreply@taftapro.com"
  layout "mailer"
end
