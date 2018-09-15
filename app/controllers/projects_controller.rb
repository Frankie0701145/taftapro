class ProjectsController < ApplicationController
  before_action :logged_in_client, only:[:edit]

  def index

    if professional_logged_in?
      @projects = Project.where(professional_id:current_professional.id ).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    elsif client_logged_in?
      @projects = Project.where(client_id:current_client.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    else
      flash[:info]= "Restricted page please login or sign up to view the page"
      redirect_to root_path
    end
  end

  def edit
    @project = Project.find(params[:id])
    @request = Request.find(@project.request_id)
  end
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_edit_params)
      flash.now[:success]="Project updated successfully"
      redirect_to projects_path
    else
      flash.now[:success]= "Project was not updated successfully"
      redirect_to projects_path
    end
  end
  def new
    @project = Project.new
    @professional_id = params[:professional_id]
    @client_id    = params[:client_id]
    @quotation_id = params[:quotation_id]
    @request_id   = params[:request_id]
  end

  def create
    @project = Project.new(project_params)
    @project.status = "started"
    if @project.save
      @quotation=Quotation.find(@project.quotation_id)
      @quotation.update_attribute(:status, "accepted")
      flash[:success] = "Project started successfully"
      redirect_to projects_path
    end
  end

  private
  def project_params
    params.require(:project).permit(:professional_id,:client_id,:quotation_id,:due,:request_id)
  end
  def project_edit_params
    params.require(:project).permit(:status)
  end
end
