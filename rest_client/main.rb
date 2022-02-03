#!/usr/bin/env ruby
require_relative 'user_client'
require_relative  'advert_client'
require_relative 'coment_client'
require_relative  'admin_client'
require_relative  'rest_const'
require 'rubygems'
require 'rest_client'
require 'json'

#user functionality
puts @user = UserClient.new("googboy", "googboy@gmail.com", "IamPass123")
puts @user.create
puts @user.login
puts @user.logout
puts @user.login
puts @user.get
puts @user.update("googboy1", "usrde@gmail.com", "IamPass123")
puts @user.get_by(@user.id)

#advert functionality
puts @advert = AdvertClient.new("googboy Advert", "I wanna to sell a car!
  So, pls by my car, i wanna cry, AAAAAAAAAAAAAAAAA dfdg")
puts @advert.token = @user.token
puts @advert.create
puts @advert.update(@advert.id, "googboy Advert 2",
   "I wanna to sell a car and spoon! ffffffffffffffff")

#comment functionality
puts @comment = CommentClient.new(@advert.id, "I wanna to sell a car and spoon!")
puts @comment.token = @user.token
puts @comment.create
puts @comment.update(@comment.id,"U ARE THE 2COOL1d1EST! SERIOSLYYY, DUDE")
puts @comment.get_by(@comment.id)

#admin functionality
puts @logget_admin = UserClient.new("admin", "admin@gmail.com", "securepassword789")
puts @logget_admin.login
puts ADMIN_TOKEN = @logget_admin.token
puts @admin = AdminClient.new(ADMIN_TOKEN)
puts @admin.refresh_headers
puts @admin.show
puts @admin.update_user(@user.id, "admin")
puts @admin.get_drafts
puts @admin.update_advert(@advert.id)
puts @advert.get
puts @advert.get_by(@advert.id)
puts @advert.show_comment(@advert.id)
puts @admin.delete_comment(@comment.id)
puts @admin.delete_advert(@advert.id)
puts @admin.delete_user(@user.id)
#File.open("rest_client/response.txt", 'a') { |file| file.write(@string_res) }
