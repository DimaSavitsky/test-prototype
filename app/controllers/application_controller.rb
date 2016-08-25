class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to landing_page_path #new_user_session_path, :alert => exception.message
  end
end
