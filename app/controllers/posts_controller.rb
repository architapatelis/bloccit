class PostsController < ApplicationController
  def index
    #declare instance variable 'posts' and assign it a array of Post objects using the all method provided by ActiveRecord.
    # instance variables created in controller method are available for use in associated view
    @posts = Post.all
    @posts.each_with_index do |post, index|
      if index % 5 == 0
        post.title = "SPAM"
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
