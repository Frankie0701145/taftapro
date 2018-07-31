class StaticPagesController < ApplicationController

  def home
  	@search_form = SearchServiceByLocationForm.new
  end

  def search
    @home_improvement_services = Service::Category.where(name: "Home Improvement").ransack(service_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {
        @location = params[:search_service_by_location_form][:location]
        @service = params[:search_service_by_location_form][:q]
     
        if !@location.empty? && !@service.empty?
          
          @professionals = 
            Professional.near(@location) & Professional.where(service: @service)

          @questions = Service::Category.find_by(service: @service).questions 

        elsif @location.empty? && !@service.empty?

          @professionals = Professional.where(service: @service)

        else
          flash.now[:info] = "Please enter a service that you are looking for."
          render 'home'
        end        
      }
      format.json {
        @home_improvement_services = @home_improvement_services.limit(5)
      }
    end
    # render json: { home_improvement: [], animals: [] }  
  end

  def about
  end
end
