class ProfessionalsController < ApplicationController
  before_action :logged_in_professional, only: [:edit, :update]
  #before_action :logged_in_client, only:[:show]
  def new
    @professional = Professional.new()
  end

  def index
    @location = params[:location]
    @service = params[:service]

    @professionals =
            Professional.near(@location) & Professional.where(service: @service)
  end

  def create
    @professional = Professional.new(professional_params)
    if @professional.save
    	professional_login(@professional)
      flash[:success] = "You have successfully registered."
      redirect_to @professional
    else
      render 'new'
    end
  end

  def show
    @professional = Professional.find(params[:id])
    @request = Request.new
    @service= @professional.service
    @location=@professional.address
    @questions = Category.find_by(service: @service).questions
    # Used to track the questions that the client answers
    @client_token = SecureRandom.hex(10)
    @client=current_client
  end

  def edit
    @professional = Professional.find(params[:id])
  end
  def update
    @professional=current_professional
    if @professional.update_attributes(professional_edit_profile_params)
      flash.now[:success]="Profile Saved successfully"
      render "edit"
    else
      flash.now[:danger]="The profile was not saved"
      render "edit"
    end
  end

  def upload_quotation
    @quotation = Quotation.new(quotation_params)
    @professional = Professional.find(params[:professional_id])
    if @quotation.save
      # TODO: Email client or create notifications
      flash[:success] = "Your quotation has been sent to the client."
      redirect_to @professional
    else
      flash.now[:danger] = "Something went wrong."
    end
  end


  private

  def professional_params
    params.require(:professional).permit(:first_name, :last_name, :email, :password, :password_confirmation, :service, :city, :country)
  end
  def professional_edit_profile_params
    params.require(:professional).permit(:first_name, :last_name, :service, :city, :country, :uniqueness_comment, :business_name, :career_start_date, :specialization)
  end

  def quotation_params
    params.require(:quotation).permit(:quotation_document, :professional_id, :client_id)
  end

end
