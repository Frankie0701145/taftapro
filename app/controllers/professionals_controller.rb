class ProfessionalsController < ApplicationController
  # before_action :logged_in_client, only: [:show]

  def new
    @professional = Professional.new()
  end

  def index
  end

  def create
    @professional = Professional.new(professional_params)
    if @professional.save
      flash[:success] = "You have successfully registered."
      redirect_to @professional
    else
      render 'new'
    end
  end

  def show
    @professional = Professional.find(params[:id])
  end

  def edit
  end

  def upload_quotation
    @quotation = Quotation.new(quotation_params)
    @professional = Professional.find(params[:professional_id])
    if @quotation.save
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

  def quotation_params
    params.require(:quotation).permit(:quotation_document, :professional_id)
  end

end
