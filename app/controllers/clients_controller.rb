class ClientsController < ApplicationController
  before_action :logged_in_professional, only: [:get_quotation]
  before_action :logged_in_client, only:[:edit]
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
  def edit
    @client = current_client
  end
  def update
    @client=current_client
    if @client.update_attributes(client_edit_profile_params)
      flash.now[:success]="Profile Saved successfully"
      render "edit"
    else
      flash.now[:danger]="The profile was not saved"
      render "edit"
    end
  end
  def get_quotation
    client_logout if current_client
    @quotation = Quotation.new
    @client_id = params[:client_id]
    @client = Client.find_by(id:params[:client_id])
    @request = Request.find_by(id:params[:request_id])
    @professional = current_professional
    #professional = Professional.find(params[:professional_id])
    #current_client.request_quotation(professional)
    #redirect_to professional
    #flash[:success] = "The quotation has been sent to your email."
  end
  def decline_quotation
    quotation = Quotation.find(params[:quotation_id])
    quotation[:status]="declined"
    if quotation.save
      flash[:info] = "Quotation is declined successfully"
      redirect_to quotations_path
    end
  end
  def quotations
    @quotations = Quotation.where(client_id: current_client.id).order("created_at DESC")
  end

  private

    def client_params
    	params.require(:client).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    def client_edit_profile_params
      params.require(:client).permit(:first_name,:last_name)
    end
end
