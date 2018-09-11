class ProjectsController < ApplicationController
  def index
  end
  def new
    @project= Project.new
    @professional_id = params[:professional_id]
    @client_id= params[:client_id]
    @quotation_id = params[:quotation_id]
  end
  def create
    @project = Project.new(project_params)
    @project.status = "started"
    if @project.save
      @quotation=Quotation.find(@project.quotation_id)
      @quotation.update_attribute(:status, "accepted")
      flash[:success].now = "Project started successfully"
      render "new"
    end
  end
  private
  def project_params
    params.require(:project).permit(:professional_id,:client_id,:quotation_id,:due)
  end
end
