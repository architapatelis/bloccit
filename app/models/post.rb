# a Ruby class which represents the Post model. This class will handle the logic and define the behavior for posts.
# Because we use 'model' generator, the Post class will 'inhert' from ActiveRecord::Base
class Post < ActiveRecord::Base
  has_many :comments
end
