class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_state]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new

    respond_to do |format|
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        ProjectChannel.broadcast_to(@project, ApplicationController.render(partial: 'projects/projects_partial', locals: { project: @project }))
        
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @project }
        format.js { render :template => 'tasks/create' }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js { @partial = render_to_string(:partial => 'shared/modal_errors', :locals => { :object => @task }); render :template => 'shared/modal_errors' }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        ProjectChannel.broadcast_to(@project, ApplicationController.render(partial: 'projects/projects_partial', locals: { project: @project }))

        format.html { redirect_to @task.project, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
        format.js { render :template => 'tasks/update' }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.js { @partial = render_to_string(:partial => 'shared/modal_errors', :locals => { :object => @task }); render :template => 'shared/modal_errors' }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_state
    if @task.incomplete?
      @task.mark_complete!
      @task.update(completed_at: Time.now)
    else 
      @task.mark_incomplete!
      @task.update(completed_at: nil)
    end

    project = @task.project
    ProjectChannel.broadcast_to(project, ApplicationController.render(partial: 'projects/projects_partial', locals: { project: project }))

    render json: {}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_at, :owner_id, :project_id)
    end
end
