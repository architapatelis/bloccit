Rails.application.routes.draw do
  # 'resources' method tells Rails to create post routes for creating, updating, viewing, deleting instances of Post.
  resources :topics do
    #nest the post routes under the topic routes
    resources :posts, except: [:index]
  end

  # only: [] - we don't want to create any /posts/:id routes, just posts/:post_id/comments routes.
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]

    # create POST routes at the URL posts/:id/up-vote
    # 'as' key points to method 'up_vote' associated this route: up_vote_path
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    #create POST routes at the URL posts/:id/down-vote
    # route: down_vote_path
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]


  # path will be /about rather than /welcome/about
  get 'about' => 'welcome#about'

  #default home page
  root 'welcome#index'
end
