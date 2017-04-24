class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  # inclusion helper has an option :in that receives the set of values that will be accepted (-1 or 1)
  validates :value, inclusion: { in: [-1,1], message: "%{value} is not a valid vote." }, presence: true
end
