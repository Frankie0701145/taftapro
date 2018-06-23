class ClientsController < ApplicationController
  before_action :logged_in_client, only: [:get_quotation]
  
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
    @quotation = Quotation.new
    if !params[:professional_id].empty?
      client_logout if current_client
      @professional = Professional.find(params[:professional_id])
      if @professional
        professional_login @professional
      end
    end
  end

  def get_quotation
    professional = Professional.find(params[:professional_id])
    current_client.request_quotation(professional)
    redirect_to professional
    flash[:success] = "The quotation has been sent to your email."
  end

  private

    def client_params
    	params.require(:client).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
