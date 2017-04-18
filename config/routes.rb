Rails.application.routes.draw do

  # 'resources' method tells Rails to create post routes for creating, updating, viewing, deleting instances of Post.
  resources :topics do
    #nest the post routes under the topic routes
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  # path will be /about rather than /welcome/about
  get 'about' => 'welcome#about'

  #default home page
  root 'welcome#index'
end
