class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      flash[:alert] = 'Please log in to continue'
      redirect_to login_path
    end
  end

  def require_admin!
    unless current_user&.admin?
      flash[:alert] = 'Access denied'
      redirect_to root_path
    end
  end
end
