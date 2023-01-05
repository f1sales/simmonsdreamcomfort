# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in simmonsdreamcomfort.gemspec
gem 'f1sales_custom-email', github: 'marciok/f1sales_custom-email', branch: 'master'
gem 'f1sales_helpers', github: 'f1sales/f1sales_helpers', branch: 'master'
gem 'f1sales_custom-hooks', github: 'marciok/f1sales_custom-hooks', branch: 'master'

gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

group :development do
  gem 'rubocop', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
end
