require "google/cloud/storage"

class ProfessionalsController < ApplicationController
  before_action :logged_in_professional, only: %i[edit update]
  before_action :allow_correct_pro_and_clients, only: [:show]


  def new
    @professional = Professional.new
  end

  def index
    @location = params[:location]
    @service = params[:service]

    nearby_pros = Professional.near(@location).to_a
    pros_offering_this_service = Professional.where(service: @service).to_a

    @professionals =
      nearby_pros & pros_offering_this_service
  end

  def create
    @professional = Professional.new(professional_params)
    if @professional.save
      professional_login(@professional)
      flash[:success] = "You have successfully registered."
      redirect_to @professional
    else
      render "new"
    end
  end

  def show
    @professional = Professional.find(params[:id])
    @service = @professional.service
    @location = @professional.address
    category = Category.find_by(service: @service) unless professional_logged_in?
    @questions = category.questions.order(:id) unless professional_logged_in?
    # Used to track the questions that the client answers
    @client_token = SecureRandom.hex(10) unless professional_logged_in?
    @client = current_client if client_logged_in?
    @reviews = @professional.reviews.order("created_at DESC").paginate(page: params[:page], per_page: 2)
    @average_review_rating = if @professional.reviews.blank?
      0
    else
      @professional.reviews.average(:rating).round(1)
    end
  end

  def edit
    @professional = current_professional
  end

  def update
    if Rails.env.production?
      storage = Google::Cloud::Storage.new project_id: ENV["GOOGLE_STORAGE_PROJECT_ID"], credentials: JSON.parse(ENV["GOOGLE_APPLICATION_CREDENTIALS"]) 
    else
      storage = Google::Cloud::Storage.new project_id: ENV["GOOGLE_STORAGE_PROJECT_ID"] 
    end

    bucket  = storage.bucket ENV["IMAGES_BUCKET"]

    file_path = params[:professional][:picture].tempfile.path
    file_name = params[:professional][:picture].original_filename

    # Upload file to Google Cloud Storage bucket
    file = bucket.create_file file_path, file_name, acl: "public"

    @professional = current_professional
    if @professional.update(professional_edit_profile_params)

      # The public URL can be used to directly access the uploaded file via HTTP
      @professional.update_attribute(:google_picture_url, file.public_url) if file

      flash.now[:success] = "Profile Saved successfully"
      render "edit"
    else
      flash.now[:danger] = "The profile was not saved"
      render "edit"
    end
  end

  def upload_quotation
    @quotation = Quotation.new(quotation_params)
    @professional = Professional.find(params[:professional_id])
    @request = Request.find(params[:request_id])
    @client_id = params[ :client_id ]
    if @quotation.save
      @request.update_attribute(:status, "Sent")
      # TODO: Email client or create notifications
      flash[:success] = "Your quotation has been sent to the client."
      redirect_to @professional
    else
      flash[:danger] = "The quotation did not save.Make sure to use figures and dont use commas."
      redirect_to request_quotation_path( client_id: @client_id, request_id: @request.id)
    end
  end

  private

    def professional_params
      params.require(:professional).permit(:first_name, :last_name, :email, :password, :password_confirmation, :service, :city, :country, :phone_number)
    end

    def professional_edit_profile_params
      params.require(:professional).permit(:first_name, :last_name, :service, :city, :country, :uniqueness_comment, :business_name, :career_start_date, :specialization, :phone_number, :bio, :picture)
    end

    def quotation_params
      params.require(:quotation).permit(:quotation_document, :professional_id, :client_id, :request_id, :amount)
    end

    def allow_correct_pro_and_clients
      @professional = Professional.find(params[:id])
      if current_professional
        unless current_client || @professional == current_professional
          redirect_to current_professional
        end
      end
    end
end
