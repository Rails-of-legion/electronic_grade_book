class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)\
    if resource.admin?
    admin_root_path
    elsif resource.teacher?
    semesters_path
    elsif resource.student?
    semesters_path
    end
    
  end
end
