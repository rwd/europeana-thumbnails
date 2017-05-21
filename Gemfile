# frozen_string_literal: true

source 'https://rubygems.org'

gem 'aws-sdk', '~> 2'
gem 'rake'
gem 'sinatra'

group :production do
  gem 'newrelic_rpm'
end

group :production, :development do
  gem 'puma'
end

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', require: false
end

group :development do
  gem 'foreman'
end

group :test do
  gem 'coveralls', require: false
  gem 'minitest'
  gem 'rack-test', require: 'rack/test'
  gem 'simplecov', require: false
  gem 'webmock'
end
