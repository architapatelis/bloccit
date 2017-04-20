class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # SessionsController inherits from ApplicationController, by including the helper here sessions controller has access to it's methods.
  include SessionsHelper
end
