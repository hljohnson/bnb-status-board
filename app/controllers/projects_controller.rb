class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where.not(aasm_state: :complete)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tasks = @project.tasks
    @users = @project.users.includes(:tasks)
  end

  # GET /projects/new
  def new
    @project = Project.new

    respond_to do |format|
      #format.html
      format.js
    end
  
  end

  # GET /projects/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to :index, notice: 'Project was successfully created.' }
        format.js { render :template => 'projects/create', notice: 'Project was sucessfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.js { @partial = render_to_string(:partial => 'shared/modal_errors', :locals => { :object => @project }); render :template => 'shared/modal_errors' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        ProjectChannel.broadcast_to(@project, ApplicationController.render(partial: 'projects/projects_partial', locals: { project: @project }))

        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
        format.js { render :template => 'projects/update' }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js {@partial = render_to_string(:partial => 'shared/modal_errors', :locals => { :object => @project }); render :template => 'shared/modal_errors'}
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :client, :aasm_state)
    end
end
