class ProfessionalsController < ApplicationController
  before_action :logged_in_client, only: [:show]

  def new
    @professional = Professional.new
  end

  def index
  end

  def show
    @professional = Professional.find(params[:id])
  end

  def edit
  end
end
