class StaticPagesController < ApplicationController
  def home
  	@search_form = SearchServiceByLocationForm.new
  end

  def search_service
  	@professionals = Professional.near(params[:search_service_by_location_form][:location], 50, :units => :km) &&
  					Professional.where(service: params[:search_service_by_location_form][:service])
  end

  def about
  end
end
