require 'rails_helper'

# type: :controller tells RSpec to treat the test as a controller test. This allows us to simulate controller actions such as HTTP requests.
RSpec.describe PostsController, type: :controller do

  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    #test route
    it "returns http success" do
      get :index
      #checks for a response code of 200, which is the standard HTTP response code for success.
      expect(response).to have_http_status(:success)
    end

    # our test created one post (my_post), we expect index to return an array of one item.
    it "assigns [my_post] to @posts" do
      get :index

      # 'assigns' gives the test access to instance variables assigned in the action that are available in the view
      expect(assigns(:posts)).to eq([my_post])
    end
  end

#  describe "GET #show" do
#    it "returns http success" do
#      get :show
#      expect(response).to have_http_status(:success)
#    end
#  end

#  describe "GET #new" do
#    it "returns http success" do
#      get :new
#      expect(response).to have_http_status(:success)
#    end
#  end

#  describe "GET #edit" do
#    it "returns http success" do
#      get :edit
#      expect(response).to have_http_status(:success)
#    end
#  end

end
