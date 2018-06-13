class ProfessionalsController < ApplicationController
  def new
  end

  def index
  end

  def show
  	@professional = Professional.find(params[:id])
  end

  def edit
  end
end
