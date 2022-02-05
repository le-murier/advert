# README

The api application for creating advertisements, comments, and login/logout users

Versions:
* ruby 2.7.0p0
* Rails 7.0.1
* postgres (PostgreSQL) 13.4

Database creation:
* $ rake db:create
* $ rake db:migrate
* $ rake db:seed

Tests 
* $ bundle exec rspec spec/models/user_spec.rb  - model tests for User model
* $ bundle exec rspec spec/models/comment_spec.rb  - model tests for Comment model
* $ bundle exec rspec spec/models/advertisement_spec.rb  - model tests for Advertisement model
* $ bundle exec rspec spec/requests/users_spec.rb - request tests for User actions
* $ bundle exec rspec spec/requests/comments_spec.rb - request tests for Comment actions
* $ bundle exec rspec spec/requests/advertisements_spec.rb - request tests for Advertisement actions

Rest client
* $ bundle install 'rest_client'
* $ bundle install 'json'
* $ ruby rest_client/main.rb 



