class PostsController < ApplicationController
  def index
    #declare instance variable 'posts' and assign it a array of Post objects using the all method provided by ActiveRecord.
    # instance variables created in controller method are available for use in associated view
    @posts = Post.all
  end

  # find the post that corresponds to the id in the params that was passed to show and assign it to @post
  def show
    @post = Post.find(params[:id])
  end

  # When new is invoked, a new and unsaved Post object is created
  def new
    @post = Post.new
  end

  # When create is invoked by clicking 'Save', the newly created object is persisted to the database.
  def create
    # we call Post.new to create a new instance of Post.
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    # if we successfully save Post to the database
    if @post.save

      flash[:notice] = "Post was saved."
      # redirect the user to the route generated by @post, the 'show' view
      redirect_to @post
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
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error saving the poast. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flas.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
end
