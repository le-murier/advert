# README

The api application for creating advertisements, comments, and login/logout users

Versions:
* ruby 2.7.0p0
* postgres (PostgreSQL) 13.4

Database creation:
* rake db:create
* rake db:migrate
* rake db:seed

Tests 
* bundle exec rspec spec/models/user_spec.rb  - model tests for User model
* bundle exec rspec spec/requests/users_spec.rb - request tests for User model



