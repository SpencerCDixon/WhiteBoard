source 'https://rubygems.org'
ruby '2.1.5'


gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

gem 'foundation-rails'
gem 'haml-rails', '~> 0.8'
gem 'omniauth-google-oauth2'

group :development do
  gem 'spring'
  gem 'dotenv-rails'
  gem 'mailcatcher'
end

group :test do
  gem 'launchy', require: false
  gem 'fuubar'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'shoulda-matchers'
  gem 'email_spec'
end

group :production do
  gem 'rails_12factor'
end
