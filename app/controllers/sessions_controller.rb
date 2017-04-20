class SessionsController < ApplicationController
  def new
  end

  def create
    # search the database for a user with specified email
    user = User.find_by(email: params[:session][:email].downcase)

    # verify that user is not nil && that the password in the params hash matches the specified password.
    if user && user.authenticate(params[:session][:password])
      # call a create_session function - in sessions_helper.rb
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  # to delete user session
  def destroy
    # call destroy_session to log out user - in sessions_helper.rb
    # current_user method - in sessions_helper.rb
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end
end
