require 'rails_helper'

RSpec.describe Post, type: :model do
  #'post' is new instance of 'Post' class
  # 'create' will create objects 'title' and 'body'. and save them to the database, if validation passes.
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }

  describe "attributes" do
    it "has title and body attributes" do
      expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
    end
  end
end
