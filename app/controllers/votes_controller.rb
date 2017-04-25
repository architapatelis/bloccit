class VotesController < ApplicationController
  # sign-in before voting
  before_action :require_sign_in

  def up_vote
    update_vote(1)
    # redirect the user back to the view that issued the request.
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  private


  def update_vote(new_value)
    @post = Post.find(params[:post_id])
    #find the relevant vote if one already exists for that post and the current user
    @vote = @post.votes.where(user_id: current_user.id).first

    if @vote
      #update the vote if it exists
      @vote.update_attribute(:value, new_value)
    else
      #create a new one if not
      @vote = current_user.votes.create(value: new_value, post: @post)
    end
  end
end
