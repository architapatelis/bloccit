module SessionsHelper
  # set user_id on the session object to user.id, which is unique for each user
  def create_session(user)
    session[:user_id] = user.id
  end

  # clear user_id by setting it to nil, therefore we can't track it via the user.id
  def destroy_session(user)
    session[:user_id] = nil
  end

  
  # finds the signed-in user by taking the user id from the session and searching the database for the user
  def current_user
    User.find_by(id: session[:user_id])
  end
end
