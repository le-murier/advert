# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@user0 = User.create(
     user_name: "testUser0",
     email: "testUser0@gmail.com",
     password: "securepassword123",
     role: "user",
)

@user1 = User.create(
      user_name: "testUser1",
      email: "testUser1@gmail.com",
      password: "securepassword456",
      role: "user",
)

@user2 = User.create(
      user_name: "admin",
      email: "admin@gmail.com",
      password: "securepassword789",
      role: "admin",
)

@advert0 = Advertisement.create(
      title: "Test advert",
      content: "We are testing some features right now",
      user_id: @user0.id,
      status: "publicated",
      views: 0,
)

@advert1 = Advertisement.create(
      title: "Draft",
      content: "I don't know what to write...",
      user_id: @user1.id,
      status: "draft",
      views: 0,
)

Comment.create(
      adverb_id: @advert0.id,
      content: "Testing Comment, dude",
      user_id: @user0.id,
)
