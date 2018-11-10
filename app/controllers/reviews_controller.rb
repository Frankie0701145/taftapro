# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :logged_in_client, only: %i[new create edit update destroy]

  def index
    project_id = params[:project_id]
    @reviews = Review.where(project_id: project_id).order('created_at DESC')
  end

  def new
    @review = Review.new
    @professional_id = params[:professional_id]
    @project_id = params[:project_id]
  end

  def create
    @review = Review.new(review_params)
    @review.client_id = current_client.id
    if @review.save
      flash[:success] = 'Review saved successfully'
      # TODO: will setup a notification system
      redirect_to projects_path
    else
      flass[:danger] = 'Review did not save try again please'
      redirect_to new_reviews_path
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(edit_review_params)
      flash[:success] = 'Review edited successfully'
      # TODO: Will setup a notification system
      redirect_to projects_path
    else
      flash.now[:danger] = 'Review did not edit try again please'
      redirect_to projects_path
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = 'Review deleted successfully'
    # TODO: will setup a notification
    redirect_to projects_path
  end

  private

  def review_params
    params.require(:review).permit(:rating, :professional_id, :project_id, :comment)
  end

  def edit_review_params
    params.require(:review).permit(:rating, :comment)
  end
end
