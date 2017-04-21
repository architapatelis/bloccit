# a Ruby class which represents the Post model. This class will handle the logic and define the behavior for posts.
# Because we use 'model' generator, the Post class will 'inhert' from ActiveRecord::Base
# When we delete a post, we also need to delete all related comments. We'll perform a "cascade delete",
class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  # default_scope will order all posts by their created_at date, in descending order, with the most recent posts displayed first.
  default_scope { order('created_at DESC') }


  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
