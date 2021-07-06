source "https://rubygems.org"

ruby "~> 2.7"

gem "will_paginate", "~> 3.3" # Must be loaded before elasticsearch gems

gem "activerecord-pg_enum", "~> 1.2"
gem "aws-sdk-s3", "~> 1.96"
gem 'caxlsx'
gem "cf-app-utils", "~> 0.6"
gem "devise", "~> 4.8"
gem "devise-encryptable", "~> 0.2"
gem "draper", "~> 4.0"
gem "elasticsearch", "~> 7.13"
gem "elasticsearch-model", "~> 7.1"
gem "elasticsearch-rails", "~> 7.1"
gem "govuk_notify_rails", "~> 2.1"
gem "image_processing"
gem "interactor", "~> 3.1"
gem "jbuilder", "~> 2.11"
gem "lograge", "~> 0.11"
gem "mini_magick", "~> 4.11"
gem "pg", "~> 1.2"
gem "pghero", "~> 2.8"
gem "puma", "~> 5.3"
gem "pundit", "~> 2.1"
gem "rack", "~> 2.2"
gem "rails", "~> 6.1.4"
gem "redcarpet", "~> 3.5"
gem "redis-rails", "~> 5.0"
gem "request_store", "~> 1.5"
gem "rest-client", "~> 2.1"
gem "sass-rails", "~> 6.0"
gem "scout_apm", "~> 4.1"
gem "sentry-rails"
gem "sentry-sidekiq"
gem "sidekiq", "~> 6.2"
gem "sidekiq-cron", "~> 1.2"
gem "slim-rails", "~> 3.2"
gem "sprockets", "4.0.2" # Unable to upgrade until https://github.com/rails/sprockets/issues/633 is resolved
gem "sprockets-rails", require: "sprockets/railtie"
gem "strong_migrations", "~> 0.7"
gem "tty-table", require: false
gem "validate_email", "~> 0.1"
gem "webpacker", "~> 5.4"
gem "wicked", "~> 1.3"

gem "govuk-design-system-rails", git: "https://github.com/UKGovernmentBEIS/govuk-design-system-rails", tag: "0.7.2", require: "govuk_design_system"

gem "bootsnap"

group :development, :test do
  gem "awesome_print", "~> 1.9", require: "ap"
  gem "byebug", "~> 11.1"
  gem "dotenv-rails", "~> 2.7"
  gem "parallel_tests"
  gem "pry", "~> 0.13"
  gem "pry-byebug", "~> 3.9"
  gem "pry-doc", "~> 1.1"
end

group :development do
  gem "listen", "~> 3.5"
  gem "m", "~> 1.5"
  gem "solargraph", "~> 0.42"
  gem "spring", "~> 2.1"
  gem "spring-commands-rspec", "~> 1.0"
end

group :test do
  gem "capybara", "~> 3.35"
  gem "capybara-screenshot", "~> 1.0"
  gem "database_cleaner", "~> 2.0"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 2.18"
  gem "launchy", "~> 2.5"
  gem "rails-controller-testing", "~> 1.0"
  gem "roo", "~> 2.8"
  gem "rspec"
  gem "rspec-mocks", "~> 3.10"
  gem "rspec-rails"
  gem "rubocop", "~> 1.15"
  gem "rubocop-govuk", "~> 4.0"
  gem "rubocop-performance", "~> 1.11"
  gem "rubocop-rspec", "~> 2.3", require: false
  gem "scss_lint-govuk", "~> 0.2"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "simplecov-console", "~> 0.9"
  gem "simplecov-lcov"
  gem "slim_lint", "~> 0.21"
  gem "super_diff"
  gem "webmock", "~> 3.13"
end
