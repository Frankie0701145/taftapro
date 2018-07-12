class StaticPagesController < ApplicationController
  def home
  	@search_form = SearchServiceByLocationForm.new
  end

  def search_service
    #@request = Request.new
  	@location = params[:search_service_by_location_form][:location]
  	@service = params[:search_service_by_location_form][:service]
  	if !@location.empty? && !@service.empty?

  		location = params[:search_service_by_location_form][:location]

  		@professionals = Professional.near(@location) &&
  					Professional.where(service: @service)
  	elsif params[:search_service_by_location_form][:location].empty?
  		#flash.now[:info] = "There's no results for the location you have entered."
      @professionals =Professional.where(service: @service)
  	elsif params[:search_service_by_location_form][:service].empty?
  		flash.now[:info] = "There's no results for the service you have entered."
  	else
  		flash.now[:info] = "There's no results for your search criteria."
    end
  end

  def about
  end

end
