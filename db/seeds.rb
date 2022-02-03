@user0 = User.create(
     user_name: "testuser0",
     email: "testUser0@gmail.com",
     password: "securepassword123",
     role: "user",
)

@user1 = User.create(
      user_name: "testuser1",
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
      title: "Draft, we dont se u",
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

Comment.create(
      adverb_id: @advert0.id,
      content: "Another new cool comment",
      user_id: @user0.id,
)

Comment.create(
      adverb_id: @advert0.id,
      content: "I am so bored of ...",
      user_id: @user1.id,
)
