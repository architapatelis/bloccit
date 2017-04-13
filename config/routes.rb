Rails.application.routes.draw do
  # 'resources' method tells Rails to create post routes for creating, updating, viewing, deleting instances of Post.
  resources :posts

  # path will be /about rather than /welcome/about
  get 'about' => 'welcome#about'

  #default home page
  root 'welcome#index'
end
