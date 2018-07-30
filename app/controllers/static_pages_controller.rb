class StaticPagesController < ApplicationController
  before_action :force_json, only: :search

  def home
  	@search_form = SearchServiceByLocationForm.new
  end

  def search_service
  	@location = params[:search_service_by_location_form][:location]
  	@service = params[:search_service_by_location_form][:service]
 
  	if !@location.empty? && !@service.empty?
  		
      @professionals = 
        Professional.near(@location) & Professional.where(service: @service)

  	elsif @location.empty? && !@service.empty?

      @professionals = Professional.where(service: @service)

  	else
      flash.now[:info] = "Please enter a service that you are looking for."
      render 'home'
    end
  end

  def search
    @home_improvement_services = Service::Category.where(name: "Home Improvement").ransack(params[:q]).result(distinct: true)

    # render json: { home_improvement: [], animals: [] }  
  end

  def about
  end

  private
    def force_json
      request.format = :json
    end

end
