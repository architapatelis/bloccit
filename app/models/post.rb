# a Ruby class which represents the Post model. This class will handle the logic and define the behavior for posts.
# Because we use 'model' generator, the Post class will 'inhert' from ActiveRecord::Base
# When we delete a post, we also need to delete all related comments and votes. We'll perform a "cascade delete".
class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  # associate comments with Post. this allows us to call post.comment
  has_many :comments, dependent: :destroy

  # associate votes with Post. allows us to call post.votes
  has_many :votes, dependent: :destroy

  # default_scope will order all posts by their rank, in descending order.
  default_scope { order('rank DESC') }


  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true


  # 'votes' is implied self.votes (i.e it calls post.votes)
  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  # ActiveRecord's :sum to add the value of all the given post's votes.
  # Passing :value to sum tells it what attribute to sum in the collection
  def points
    votes.sum(:value)
  end

  # Using a time-decay algorithm like this will keep our post ranks fresh.
  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
end
