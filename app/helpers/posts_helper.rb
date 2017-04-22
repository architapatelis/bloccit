#methods listed here are available for use in the post views

module PostsHelper

  # checks if there is a signed-in current_user, and if that  current_user either owns the post, or is an admin.
  def user_is_authorized_for_post?(post)
    current_user && (current_user == post.user) || current_user.admin?
  end
end
