require 'test_helper'

class ClientSignupTest < ActionDispatch::IntegrationTest
  test "invalid client" do
  	@client = Client.create(name: "", email: "babla@gmail.com")
    assert_not @client.valid?
  end

  test "valid client" do
  	@client = Client.create(name: "John Doe", email: "johndoe@gmail.com")
    assert @client.valid?
  end  
end
