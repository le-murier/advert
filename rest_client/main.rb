#!/usr/bin/env ruby
require_relative 'user_client'
require_relative  'advert_client'
require_relative 'coment_client'
require_relative  'admin_client'
require_relative  'rest_const'
require 'rubygems'
require 'rest_client'
require 'json'
@resut_to_write = ""

#user functionality
@array_to_save = [
  @user = UserClient.new("googboy", "googboy@gmail.com", "IamPass123"),
  @user.create, @user.login, @user.logout, @user.login, @user.get,
  @user.update("googboy1", "usrde@gmail.com", "IamPass123"),
  @user.get_by(@user.id),

  #advert functionality
  @advert = AdvertClient.new("googboy Advert", "I wanna to sell a car!,
    So, pls by my car, i wanna cry, AAAAAAAAAAAAAAAAA dfdg"),
  @advert.token = @user.token, @advert.create,
  @advert.update(@advert.id, "googboy Advert 2",
     "I wanna to sell a car and spoon! ffffffffffffffff"),

  #comment functionality
  @comment = CommentClient.new(@advert.id, "I wanna to sell a car and spoon!"),
  @comment.token = @user.token, @comment.create,
  @comment.update(@comment.id,"U ARE THE 2COOL1d1EST! SERIOSLYYY, DUDE"),
  @comment.get_by(@comment.id),

  #admin functionality
  @logget_admin = UserClient.new("admin", "admin@gmail.com", "securepassword789"),
  @logget_admin.login, ADMIN_TOKEN = @logget_admin.token,
  @admin = AdminClient.new(ADMIN_TOKEN), @admin.refresh_headers, @admin.show,
  @admin.update_user(@user.id, "admin"), @admin.get_drafts,
  @admin.update_advert(@advert.id), @advert.get, @advert.get_by(@advert.id),
  @advert.show_comment(@advert.id), @admin.delete_comment(@comment.id),
  @admin.delete_advert(@advert.id), @admin.delete_user(@user.id),
]
@array_to_save.each do |n|
  @resut_to_write += "#{n}\n"
end
File.open("rest_client/response.txt", 'a') { |file| file.write(@resut_to_write) }
