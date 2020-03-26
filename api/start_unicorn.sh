#!/usr/bin/env bash
cd /var/www/api.jacks.reviews/
export RAILS_ENV=production; rbenv exec bundle exec unicorn_rails -c /var/www/api.jacks.reviews/config/unicorn.rb -D
cd -
