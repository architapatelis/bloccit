# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

50.times do
  # bang(!) instructs 'create' method to raise error if there's a problem with seeded data.
  Post.create!(

    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all


100.times do
  Comment.create!(

  # 'sample' method returns a random element from the array returned by 'Post.all'
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

20.times do
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: RandomData.random_boolean
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
