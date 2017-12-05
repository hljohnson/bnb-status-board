class ProfilesController < ApplicationController
  def show
    @profile_widgets = [VacationProfileWidget].map do |widget|
      widget.configured_for(user: current_user)
    end.compact
  end

  def edit

  end

  def update
    if current_user.update(user_params)
      redirect_to(action: :show)
    else
      render :edit
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:freshbooks_api_key, :max_vacation_hours])
  end

  private

  def user_params
    params.require(:user).permit(:freshbooks_api_key, :max_vacation_hours)
  end
end