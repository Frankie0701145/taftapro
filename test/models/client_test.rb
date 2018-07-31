# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  reset_digest    :string
#  reset_sent_at   :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_clients_on_email  (email) UNIQUE
#

require 'test_helper'

class ClientTest < ActiveSupport::TestCase
	def setup
		@client = Client.new(first_name: "John", last_name: "Doe", email: "johndoe@gmail.com",
							password: "foobar", password_confirmation: "foobar")
	end

  test "should be a valid client" do
    assert @client.valid?
  end  
  
  # test "first name should be present" do
  # 	@client.first_name = " "
  #   assert_not @client.valid?   
  # end  

  # test "last name should be present" do
  # 	@client.last_name = " "
  #   assert_not @client.valid?   
  # end    

  test "email should be present" do
  	@client.email = " "
    assert_not @client.valid?   
  end    

	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
							first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@client.email = valid_address
			assert @client.valid?, "#{valid_address.inspect} should be valid"
		end  
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
								foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@client.email = invalid_address
			assert_not @client.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end	

	test "email addresses should be unique" do
		duplicate_client = @client.dup
		duplicate_client.email = @client.email.upcase
		@client.save
		assert_not duplicate_client.valid?	
	end

	test "email addresses should be saved as lower-case" do
		mixed_case_email = "Foo@ExAMPle.CoM"
		@client.email = mixed_case_email
		@client.save
		assert_equal mixed_case_email.downcase, @client.reload.email
	end	

	test "password should be present (nonblank)" do
		@client.password = @client.password_confirmation = " " * 6
		assert_not @client.valid?
	end

	test "password should have a minimum length" do
		@client.password = @client.password_confirmation = "a" * 5
		assert_not @client.valid?
	end	
end
