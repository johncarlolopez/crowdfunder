class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :categories

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound => e
      
    end
  end

  def require_login
    unless session[:user_id]
      not_authenticated
    end
  end

  def categories
    @categories = Category.all
  end

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
