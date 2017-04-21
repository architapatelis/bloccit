#controllers are classes, and all controllers inherit from the  ApplicationController class.

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # SessionsController inherits from ApplicationController, by including the helper here sessions controller has access to it's methods.
  include SessionsHelper


  private
  # to redirect un-signed-in users. We define this method in ApplicationController because we'll eventually want to call it from other controllers.
  # redirect un-signed-in users to the sign-in page

  def require_sign_in
    unless current_user
      flash[:alert] = "You must be logged in to do that"
      redirect_to new_session_path
    end
  end
end
