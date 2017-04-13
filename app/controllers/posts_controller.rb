class PostsController < ApplicationController
  def index
    #declare instance variable 'posts' and assign it a array of Post objects using the all method provided by ActiveRecord.
    # instance variables created in controller method are available for use in associated view
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
