source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.2"

# The modern asset pipeline for Rails
gem "propshaft"

# Database
gem "mysql2", "~> 0.5"

# Web server
gem "puma", ">= 5.0"

# JS & hotwire
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# JSON builder
gem "jbuilder"

# Timezone for Windows
gem "tzinfo-data", platforms: %i[windows jruby]

# Rails.cache, Active Job, Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Speed up booting
gem "bootsnap", require: false

# Deployment via Docker containers
gem "kamal", require: false

# Faster static files for Puma
gem "thruster", require: false

# Image transformation
gem "image_processing", "~> 1.2"

# ---- Development & Test ----
group :development, :test do
  # Debugging
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Security scanners
  gem "bundler-audit", require: false
  gem "brakeman", require: false

  # Lint
  gem "rubocop-rails-omakase", require: false

  # Environment variables
  gem "dotenv-rails"
end

# ---- Development only ----
group :development do
  gem "web-console"
end

# ---- Test only ----
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
gem 'devise'