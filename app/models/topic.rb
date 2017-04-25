class Topic < ActiveRecord::Base
  # associate posts with Topic. allows us to call topic.posts
  has_many :posts, dependent: :destroy
end
