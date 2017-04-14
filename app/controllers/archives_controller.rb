class ArchivesController < ApplicationController

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(aasm_state: :complete)
    @users = User.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
    @users = @project.users.includes(:tasks)

    respond_to do |format|
      format.js { render :template => 'archives/show'}
    end

  end
end
