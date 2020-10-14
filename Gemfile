source "https://rubygems.org"

ruby "~> 2.7.1"

gem "will_paginate", "~> 3.3" # Must be loaded before elasticsearch gems

gem "activerecord-pg_enum", "~> 1.1"
gem "aws-sdk-s3", "~> 1.83"
gem "axlsx", git: "https://github.com/randym/axlsx.git", ref: "c593a08"
gem "caxlsx_rails", "~> 0.6.2"
gem "cf-app-utils", "~> 0.6"
gem "devise", "~> 4.7"
gem "devise-encryptable", "~> 0.2"
gem "draper", "~> 4.0"
gem "elasticsearch", "~> 6.8"
gem "elasticsearch-model", "~> 6.1"
gem "elasticsearch-rails", "~> 6.1"
gem "govuk_notify_rails", "~> 2.1"
gem "interactor", "~> 3.1"
gem "jbuilder", "~> 2.10"
gem "lograge", "~> 0.11"
gem "mini_magick", "~> 4.10"
gem "pg", "~> 1.2"
gem "pghero", "~> 2.7"
gem "puma", "~> 5.0"
gem "pundit", "~> 2.1"
gem "rack", "~> 2.2"
gem "rails", "~> 6.0"
gem "rails_admin", "~> 2.0"
gem "redcarpet", "~> 3.5"
gem "redis-rails", "~> 5.0"
gem "request_store", "~> 1.5"
gem "rest-client", "~> 2.1"
gem "sass-rails", "~> 6.0"
gem "scout_apm", "~> 2.6"
gem "sentry-raven", "~> 3.1"
gem "sidekiq", "5.2.9" # Required version until GOV.UK PaaS upgrades Redis to 4.0.0
gem "sidekiq-cron", "~> 1.2"
gem "slim-rails", "~> 3.2"
gem "sprockets", "3.7.2" # Unable to upgrade until https://github.com/rails/sprockets/issues/633 is resolved
gem "sprockets-rails", require: "sprockets/railtie"
gem "strong_migrations", "~> 0.7"
gem "tty-table", require: false
gem "validate_email", "~> 0.1"
gem "webpacker", "~> 5.2"
gem "wicked", "~> 1.3"

gem "govuk-design-system-rails", git: "https://github.com/UKGovernmentBEIS/govuk-design-system-rails", tag: "0.7.1", require: "govuk_design_system"

group :development, :test do
  gem "awesome_print", "~> 1.8", require: "ap"
  gem "byebug", "~> 11.1"
  gem "dotenv-rails", "~> 2.7"
  gem "pry", "~> 0.13"
  gem "pry-byebug", "~> 3.9"
  gem "pry-doc", "~> 1.1"
end

group :development do
  gem "listen", "~> 3.2"
  gem "m", "~> 1.5"
  gem "solargraph", "~> 0.39"
  gem "spring", "~> 2.1"
  gem "spring-commands-rspec", "~> 1.0"
end

group :test do
  gem "capybara", "~> 3.33"
  gem "capybara-screenshot", "~> 1.0"
  gem "coveralls", "~> 0.7"
  gem "database_cleaner", "~> 1.8"
  gem "factory_bot_rails", "~> 6.1"
  gem "faker", "~> 2.14"
  gem "launchy", "~> 2.5"
  gem "rails-controller-testing", "~> 1.0"
  gem "roo", "~> 2.8"
  gem "rspec-mocks", "~> 3.9"
  gem "rspec-rails", "~> 4.0"
  gem "rubocop", "~> 0.87"
  gem "rubocop-govuk", "~> 3.17"
  gem "rubocop-performance", "~> 1.8"
  gem "rubocop-rspec", "~> 1.42", require: false
  gem "scss_lint-govuk", "~> 0.2"
  gem "simplecov", "~> 0.19"
  gem "simplecov-console", "~> 0.7"
  gem "slim_lint", "~> 0.20"
  gem "webmock", "~> 3.9"
end
