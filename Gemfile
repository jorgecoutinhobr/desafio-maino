source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# add
gem "image_processing", "~> 1.2"
gem 'devise'
gem 'devise-i18n'
gem 'pagy'
gem 'faker'
gem 'rails-i18n', '~> 7.0.0'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]

  #add
  gem 'rspec-rails', '~> 6.1.0'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
  gem 'rails-mermaid_erd'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'shoulda-matchers', '~> 6.0'
end

gem "dockerfile-rails", ">= 1.6", :group => :development

gem "redis", "~> 5.2"
