class ArchiveController < ApplicationController

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @users = User.all

    respond_to do |format|
      format.html
      format.js
    end
  end
end
