class ClientsController < ApplicationController
  def new
  	@client = Client.new
  end

  def create
  	@client = Client.new(client_params)
  	if @client.save
  		flash[:success] = "You have successfully registered."
      client_login(@client)
  		redirect_to @client
  	else
  		render 'new'
  	end
  end

  def show
  	@client = Client.find(params[:id])
  end

  private

    def client_params
    	params.require(:client).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
