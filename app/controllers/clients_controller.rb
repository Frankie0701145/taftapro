# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :logged_in_professional, only: [:get_quotation]
  before_action :logged_in_client, only: %i[edit change_password]
  before_action :allow_correct_client, only: [:show]
  before_action :allow_correct_pro, only: [:get_quotation]
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = 'You have successfully registered.'
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
    @client = current_client
    if @client.update(client_edit_profile_params)
      flash.now[:success] = 'Profile Saved successfully'
      # TODO: will later add a notification system either through email or else
      render 'edit'
    else
      flash.now[:danger] = 'The profile was not saved'
      render 'edit'
    end
  end

  def change_password
    @client = current_client
    if @client.authenticate(params[:client][:old_password])
      if @client.update(change_password_params)
        flash.now[:success] = 'Password changed successfully'
        # TODO: will later add a notification system either through email or else
        render 'edit'
      else
        render 'edit'
      end
    else
      flash.now[:danger] = 'The old password is wrong'
      render 'edit'
    end
  end

  def get_quotation
    @quotation = Quotation.new
    @client_id = params[:client_id]
    @client = Client.find_by(id: params[:client_id])
    @request = Request.find_by(id: params[:request_id])
    @professional = current_professional
  end

  def decline_quotation
    quotation = Quotation.find(params[:quotation_id])
    quotation[:status] = 'declined'
    if quotation.save
      flash[:info] = 'Quotation is declined successfully'
      # TODO: will later add a notification system either through email or else
      redirect_to quotations_path
    end
  end

  def quotations
    @quotations = Quotation.where(client_id: current_client.id).order('created_at DESC')
  end

  def quotation
    @quotation = Quotation.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def client_edit_profile_params
    params.require(:client).permit(:first_name, :last_name)
  end

  def change_password_params
    params.require(:client).permit(:password, :password_confirmation)
  end

  def allow_correct_client
    @client = Client.find(params[:id])
    redirect_to current_client unless @client == current_client
  end

  def allow_correct_pro
    @request = Request.find_by(id: params[:request_id])

    unless @request.professional_id == current_professional.id
      flash[:info] = 'You are not allowed to view this page.'
      redirect_to current_professional
    end
  end
end
