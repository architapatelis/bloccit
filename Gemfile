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
  gem 'pry-rails'
end

# add the rspec-rails gem
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
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
