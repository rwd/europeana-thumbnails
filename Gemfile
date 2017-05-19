# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.1'

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
  gem 'rubocop', '0.39.0', require: false # only update when Hound does
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
