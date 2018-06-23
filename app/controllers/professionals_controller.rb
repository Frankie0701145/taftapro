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

  private

    def professional_params
      params.require(:professional).permit(:first_name, :last_name, :email, :password, :password_confirmation, :service, :city, :country)
    end
end
