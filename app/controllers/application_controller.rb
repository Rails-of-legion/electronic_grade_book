class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.teacher?
      semesters_path
    elsif resource.student?
      notifications_path
    end
  end

  private

  def authenticate_admin_user!
    redirect_to(root_path) unless current_user.try(:admin?)
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end
end
