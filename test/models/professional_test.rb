# == Schema Information
#
# Table name: professionals
#
#  id              :integer          not null, primary key
#  city            :string
#  country         :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  latitude        :float
#  longitude       :float
#  password_digest :string
#  reset_digest    :string
#  reset_sent_at   :datetime
#  service         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ProfessionalTest < ActiveSupport::TestCase

  def setup
    @professional =Professional.new(first_name: "John", last_name: "Doe", email: "johndoe@gmail.com",
							password: "foobar", password_confirmation: "foobar", city: "Nakuru", country: "Kenya", service: "Plumbing")
  end

  test "should be a valid professional" do
    assert @professional.valid?
  end

  test "first name should be present" do
  	@professional.first_name = " "
    assert_not @professional.valid?
  end

  test "last name should be present" do
  	@professional.last_name = " "
    assert_not @professional.valid?
  end

  #password validation test
  test "password should be present (nonblank)" do
		@professional.password = @professional.password_confirmation = " " * 6
		assert_not @professional.valid?
	end

	test "password should have a minimum length" do
		@professional.password = @professional.password_confirmation = "a" * 5
		assert_not @professional.valid?
	end

  #email validation
  test "email should be present" do
  	@professional.email = " "
    assert_not @professional.valid?
  end

  test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
							first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@professional.email = valid_address
			assert @professional.valid?, "#{valid_address.inspect} should be valid"
		end
	end

  test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
								foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@professional.email = invalid_address
			assert_not @professional.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

  test "email addresses should be unique" do
    duplicate_professional = @professional.dup
    duplicate_professional.email = @professional.email.upcase
    @professional.save
    assert_not duplicate_professional.valid?
  end

  test "email addresses should be saved as lower-case" do
		mixed_case_email = "Foo@ExAMPle.CoM"
		@professional.email = mixed_case_email
		@professional.save
		assert_equal mixed_case_email.downcase, @professional.reload.email
	end

  #service validation test
  test "service should be present" do
  	@professional.service = " "
    assert_not @professional.valid?
  end

end
