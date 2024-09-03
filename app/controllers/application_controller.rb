class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery
  before_action :authenticate_user!

  around_action :switch_locale

  def after_sign_in_path_for(resource)
    if resource.admin?
      user_path(resource)
    elsif resource.teacher?
      user_path(resource)
    elsif resource.student?
      user_path(resource)
    end
  end

  private

  def default_title
    action_name.humanize
  end

  def authenticate_admin_user!
    redirect_to(root_path) unless current_user.try(:admin?)
  end

  def access_denied(exception)
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/403.html", status: :forbidden, layout: false }
      format.json { render json: { error: exception.message }, status: :forbidden }
      format.any { head :forbidden }
    end
  end

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]
    return locale if I18n.available_locales.map(&:to_s).include?(locale)

    nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
  rescue_from CanCan::AccessDenied do |exception|
    access_denied(exception)
  end
end
