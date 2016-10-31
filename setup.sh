#! /bin/sh

bundle install --path=vendor/bundle
cp config.sample.yml config.yml
#RACK_ENV=development bundle exec rake db:migrate
