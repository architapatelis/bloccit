# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

users = User.all

15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end

topics = Topic.all


50.times do
  # bang(!) instructs 'create' method to raise error if there's a problem with seeded data.
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )


  # update the time a post was created. This makes our seeded data more realistic.
  post.update_attribute(:created_at, rand(10.minutes..1.year).ago)


  # create between 1-5 votes for each post. [-1, 1].sample randomly creates either an up or down vote.
  rand(1..5).times { post.votes.create!(value: [-1,1].sample, user: users.sample) }
  
end

posts = Post.all

100.times do
  Comment.create!(

  # 'sample' method returns a random element from the array returned by 'Post.all' and User.all
  user: users.sample,
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
