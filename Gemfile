source 'https://rubygems.org'

 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

 # specify database for Production environment
 # heroku only supports Postgres, so we use 'pg'
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# specify Database for our Development environment
group :development do
  gem 'sqlite3'
end

# add the rspec-rails gem
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  # to write association tests for 'topics' and 'posts' - provides methods not found in RSpec
  gem 'shoulda'
  # allows us to build objects we can use for testing.
  #Factories allow us to modify the behavior of a given object type in a single place.
  gem 'factory_girl_rails', '~> 4.0'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

#Sass-powered version of Bootstrap
gem 'bootstrap-sass'

# to use Ruby's 'has_secure_password' method we need BCrypt. Used for encrypting user passwords
gem 'bcrypt'

# to store SendGrid username and password as environment variables.
gem 'figaro', '1.0'
