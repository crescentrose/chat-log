source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0'
gem 'rails-i18n'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# We are lazy and use bootstrap
gem 'bootstrap', '~> 5.1.3'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# CORS
gem 'rack-cors'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Queue up log processing
gem 'sidekiq', '~> 6.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Slim is a template language whose goal is to reduce the syntax to the
# essential parts without becoming cryptic.
gem 'slim'

# ⚡ A Scope & Engine based, clean, powerful, customizable and sophisticated
# paginator for Ruby webapps
gem 'kaminari'

# Object-based searching.
gem 'ransack'

# OmniAuth is a flexible authentication system utilizing Rack middleware.
gem 'omniauth'
gem 'omniauth-rails_csrf_protection'
gem 'rexml'

# Steam authentication strategy for OmniAuth
gem 'omniauth-steam'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'

# Rails view helper to manage "active" state of a link
gem 'active_link_to'

# A flexible RCON client written in Ruby, based on the Source RCON protocol.
gem 'rconrb', require: 'rcon'

# Lightweight job scheduler extension for Sidekiq
gem 'sidekiq-scheduler'

# Pure Ruby implementation of an SSH (protocol 2) client
gem 'bcrypt_pbkdf'
gem 'ed25519'
gem 'net-ssh', require: 'net/ssh'

# Pure Ruby implementation of the SCP protocol
gem 'net-scp', require: 'net/scp'

# Simple, but flexible HTTP client library, with support for multiple backends.
gem 'faraday'

# Put another nickel in the swearjar. Simple profanity detection with content
# analysis.
gem 'swearjar'

# Concurrent wrappers for native Ruby IO & Sockets.
gem 'async'
gem 'async-io'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # We use a real testing library
  gem 'rspec-rails'

  # Factory Bot ♥ Rails
  gem 'factory_bot_rails'

  # A Ruby gem to load environment variables from `.env`.
  gem 'dotenv-rails'

  # Record your test suite's HTTP interactions and replay them during future
  # test runs for fast, deterministic, accurate tests.
  gem 'vcr'

  # Library for stubbing and setting expectations on HTTP requests in Ruby.
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'annotate'
end
