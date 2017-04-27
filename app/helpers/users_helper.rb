module UsersHelper
  def user_has_no_posts?(user)
    user && user.posts.count == 0
  end

  def user_has_no_comments?(user)
    user && user.comments.count == 0
  end

  def user_has_favorites?(user)
    user.favorites.count == 0
  end

end
