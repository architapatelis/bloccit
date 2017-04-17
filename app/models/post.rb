# a Ruby class which represents the Post model. This class will handle the logic and define the behavior for posts.
# Because we use 'model' generator, the Post class will 'inhert' from ActiveRecord::Base
# When we delete a post, we also need to delete all related comments. We'll perform a "cascade delete",
class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy
end
