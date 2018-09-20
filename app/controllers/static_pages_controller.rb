class StaticPagesController < ApplicationController

  def home
  	@search_form = SearchServiceByLocationForm.new
  end

  def search
    @animals_services = Category.where(name: "Animals").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @business_services = Category.where(name: "Business").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @carpentry_services = Category.where(name: "Carpentry").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @design_and_web_services = Category.where(name: "Design and Web").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @events_services = Category.where(name: "Events").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @home_improvement_services = Category.where(name: "Home Improvement").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @legal_services = Category.where(name: "Legal").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @lessons_services = Category.where(name: "Lessons").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @mechanical_services = Category.where(name: "Mechanical").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @personal_services = Category.where(name: "Personal").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @photography_services = Category.where(name: "Photography").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @repair_and_technical_support_services = Category.where(name: "Repair and Technical Support").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @security_services = Category.where(name: "Security").ransack(service_cont: params[:q]).result(distinct: true).limit(5)
    @transport_services = Category.where(name: "Transport").ransack(service_cont: params[:q]).result(distinct: true).limit(5)

    respond_to do |format|
      format.html {
        @location = params[:search_service_by_location_form][:location]
        @service = params[:search_service_by_location_form][:q]

        if !@location.empty? && !@service.empty?

          @professionals =
            Professional.near(@location) & Professional.where(service: @service)

        elsif @location.empty? && !@service.empty?

          @professionals = Professional.where(service: @service)

        else
          flash.now[:info] = "Please enter a service that you are looking for."
          render 'home'
        end
      }
      format.json {
        [@animals_services, @business_services, @carpentry_services, @design_and_web_services, @events_services, 
          @home_improvement_services, @legal_services, @lessons_services, @mechanical_services, @personal_services,
          @photography_services, @repair_and_technical_support_services, @security_services, @transport_services]
      }
    end
    # render json: { animals_services: [], ... transport_services: [] }
  end

  def about
  end
end
