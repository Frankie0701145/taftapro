# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Returns true if the client is logged in, false otherwise.
  def client_is_logged_in?
    !session[:client_id].nil?
  end

  def professional_is_logged_in?
    !session[:professional_id].nil?
  end
end
