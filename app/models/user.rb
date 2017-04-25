class User < ActiveRecord::Base
  # when parent user deletes account all of their assocaites posts, comments, votes are deleted.
  # allows us to use user.posts, user.comments, user.votes
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  # inline callback
  # downcase is run when callback executes
  before_save { self.email = email.downcase if email.present? }

  # shorthand for self.role = :member if self.role.nil?.
  before_save { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  #validation when password is first being created
  validates :password, presence: true, length: { minimum: 6}, if: "password_digest.nil?"

  # when password is updated.
  # allow_blank: true skips validation if password is not being updated but other fields are being updated.
  validates :password, length: { minimum: 6 }, allow_blank: true


  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  # has_secure_password requires a password_digest attribute on the model it is applied to
  has_secure_password

  enum role: [:member, :admin]
end
