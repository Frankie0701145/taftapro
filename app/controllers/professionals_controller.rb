class ProfessionalsController < ApplicationController
  before_action :logged_in_client, only: [:show]

  def new
  end

  def index
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
  def quotation_params
    params.require(:quotation).permit(:quotation_document, :professional_id)
  end
end
