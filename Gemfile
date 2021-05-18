source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'puma',                       '~> 4.3'
gem 'rails',                      '~> 5.1.3'
gem 'devise'
gem 'sqlite3'
gem 'uglifier',                   '>= 1.3.0'
gem 'slim-rails'
gem 'turbolinks',                 '~> 5'
gem 'sass-rails',                 '~> 5.0'
gem 'coffee-rails',               '~> 4.2'
gem 'semantic-ui-sass'
gem 'jquery-rails'
gem 'font-awesome-sass'

group :development, :test do
  gem 'pry'
  gem 'byebug'
  gem 'launchy'
  gem 'timecop'
  gem 'rubocop'
  gem 'capybara',                 '~> 2.13'
  gem 'simplecov',                require: false
  gem 'rspec-rails',              '~> 3.6'
  gem 'cucumber-rails',           require: false
  gem 'validation_rage'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers',         '~> 3.0'
  gem 'selenium-webdriver'
  gem 'rails-controller-testing'
end

group :development do
  gem 'spring'
  gem 'listen',                '>= 3.0.5', '< 3.2'
  gem 'web-console',           '>= 3.3.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
