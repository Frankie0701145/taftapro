class ReviewsController < ApplicationController
  before_action :logged_in_client, only:[:new,:create]


  def new
      @review = Review.new
      @professional_id = params[:professional_id]
  end

  def create
      @review = Review.new(review_params)
      @review.client_id = current_client.id
      if @review.save
        flash.now[:success]= "Review saved successfully"
        redirect_to projects_path
      else
        flass.now[:danger] = "Review did not save try again"
        redirect_to new_reviews_path
      end
  end

  private

  def review_params
    params.require(:review).permit(:rating,:review,:professional_id)
  end
end
