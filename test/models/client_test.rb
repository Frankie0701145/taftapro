require 'test_helper'

class ClientTest < ActiveSupport::TestCase
	def setup
		@client = Client.new(name: "John Doe", email: "johndoe@gmail.com")
	end

  test "should be a valid client" do
    assert @client.valid?
  end  
  
  test "name should be present" do
  	@client.name = " "
    assert_not @client.valid?   
  end  

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
end
