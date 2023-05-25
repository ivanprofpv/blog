# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password') if Rails.env.development?

user = User.create!(
        email: 'user@blog.com',
        password: 12345678,
        password_confirmation: 12345678
        )

Post.create!([
  {
    "title": "title - 1",
    "body": "body text - 1",
    "user_id": user.id,
    "is_active": true
  },
  {
    "title": "title - 2",
    "body": "body text - 2",
    "user_id": user.id,
    "is_active": true
  },
  {
    "title": "title - 3",
    "body": "body text - 3",
    "user_id": user.id,
    "is_active": true
  },
  {
    "title": "title - 4",
    "body": "body text - 4",
    "user_id": user.id,
    "is_active": true
  },
  {
    "title": "title - 5",
    "body": "body text - 5",
    "user_id": user.id,
    "is_active": true
  },
  {
    "title": "title - 6",
    "body": "body text - 6",
    "user_id": user.id,
    "is_active": false
  },
  {
    "title": "title - 7",
    "body": "body text - 7",
    "user_id": user.id,
    "is_active": true
  }
])

Comment.create!(
        body: 'comment test',
        post_id: 7,
        user_id: user.id,
        )
