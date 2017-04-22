class PostsController < ApplicationController

  #don't need 'index' view method since all posts will be displayed with respect to a topic, on the topic 'show' view

  # to redirect guest users from actions they won't be able to access
  # call the require_sign_in method before each of our controller actions, except for the show action.
  before_action :require_sign_in, except: :show

  # If the current_user isn't authorized based on their role, we'll redirect them to the posts show view.
  before_action :authorize_user, except: [:show, :new, :create]

  # find the post that corresponds to the id in the params that was passed to show and assign it to @post
  def show
    @post = Post.find(params[:id])
  end

  # When new is invoked, a new and unsaved Post object is created
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  # When create is invoked by clicking 'Save', the newly created object is persisted to the database.
  def create
    @topic = Topic.find(params[:topic_id])
    # use @topic variable to access the posts array that's associated with it
    # .build will build a new post associated with that topic
    @post = @topic.posts.build(post_params)

    @post.user = current_user
    # if we successfully save Post to the database
    if @post.save

      flash[:notice] = "Post was saved."
      # redirect the user to the route generated by @post, the 'show' view
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end


  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  # white list post parameters via post_params method.
  private

  # .require makes sure a post param is always passed to .build method.
  # .permit allows specified attributes
  def post_params
    params.require(:post).permit(:title, :body)
  end

  # redirect the user unless they own the post they're attempting to modify, or they're an admin.

  def authorize_user
    post = Post.find(params[:id])

    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end
  end
end
