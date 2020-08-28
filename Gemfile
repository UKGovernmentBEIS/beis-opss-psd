source "https://rubygems.org"

ruby "~> 2.6.6"

gem "will_paginate", "~> 3.3" # Must be laoded before elasticsearch gems

gem "activerecord-pg_enum"
gem "aws-sdk-s3", "1.79.1"
gem "axlsx", git: "https://github.com/randym/axlsx.git", ref: "c593a08"
gem "caxlsx_rails", "~> 0.6.2"
gem "cf-app-utils"
gem "devise"
gem "devise-encryptable"
gem "draper"
gem "elasticsearch", "~> 6.8.2"
gem "elasticsearch-model", "~> 6.1"
gem "elasticsearch-rails", "~> 6.1"
gem "govuk_notify_rails", "2.1.2"
gem "interactor"
gem "jbuilder"
gem "lograge", "0.11.2"
gem "mini_magick", "4.10.1"
gem "pg"
gem "pghero"
gem "puma"
gem "pundit"
gem "rack", "~> 2.2.3"
gem "rails", "~> 5.2"
gem "rails_admin", "~> 2.0"
gem "redcarpet"
gem "redis-rails"
gem "request_store", "1.5.0"
gem "rest-client", "2.1.0"
gem "rubyzip"
gem "scout_apm"
gem "sentry-raven", "~> 3.0"
gem "sidekiq", "5.2.9" # Required version until GOV.UK PaaS upgrades Redis to 4.0.0
gem "sidekiq-cron", "~> 1.2"
gem "slim-rails"
gem "sprockets", "3.7.2" # Unable to upgrade until https://github.com/rails/sprockets/issues/633 is resolved
gem "sprockets-rails", require: "sprockets/railtie"
gem "strong_migrations", "0.7.1"
gem "validate_email", "~> 0.1"
gem "webpacker", "~> 5.2.1"
gem "wicked"

gem "govuk-design-system-rails", git: "https://github.com/UKGovernmentBEIS/govuk-design-system-rails", tag: "0.7.0", require: "govuk_design_system"
group :development, :test do
  gem "awesome_print", require: "ap"
  gem "brakeman"
  gem "byebug"
  gem "capybara"
  gem "coveralls", "~> 0.8"
  gem "debase"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "listen"
  gem "m"
  gem "pry"
  gem "pry-byebug"
  gem "pry-doc"
  gem "roo"
  gem "rspec-mocks"
  gem "rspec-rails"
  gem "rubocop"
  gem "rubocop-govuk", "~> 3.16.0"
  gem "rubocop-performance"
  gem "rubocop-rspec", "~> 1.39", require: false
  gem "ruby-debug-ide"
  gem "sass-rails", "~> 6.0"
  gem "sassc"
  gem "scss_lint-govuk"
  gem "simplecov"
  gem "slim_lint", "0.20.1"
  gem "solargraph"
  gem "spring"
  gem "spring-commands-rspec"
  gem "webmock"
end

group :test do
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "faker"
  gem "launchy"
  gem "rails-controller-testing"
end
