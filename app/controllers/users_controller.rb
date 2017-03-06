class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@projects = @user.projects.includes(:tasks)
	end

	private
	def user_params
	  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

end