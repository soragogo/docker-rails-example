#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby dependencies
bundle install

# Precompile assets
bundle exec rake assets:precompile

# Clean up old assets
bundle exec rake assets:clean

# Database migrations
bundle exec rake db:migrate
