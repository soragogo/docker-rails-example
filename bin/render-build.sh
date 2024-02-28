#!/usr/bin/env bash
# exit on error
set -o errexit

# Check if yarn is installed and show version
if command -v yarn >/dev/null 2>&1; then
    echo "Yarn is installed."
    yarn --version
else
    echo "Yarn is not installed."
    exit 1
fi

# Continue with the rest of the script if yarn is confirmed to be installed
yarn build

# Install Ruby dependencies
bundle install

# Precompile assets
bundle exec rake assets:precompile

# Clean up old assets
bundle exec rake assets:clean

# Database migrations
bundle exec rake db:migrate
