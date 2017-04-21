require 'rails_helper'

# so that we can use the create_session(user) method later in the spec.
include SessionsHelper

# type: :controller tells RSpec to treat the test as a controller test. This allows us to simulate controller actions such as HTTP requests.
RSpec.describe PostsController, type: :controller do

  # guest (un-signed-in) user.
  let(:my_user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}

  #create parent 'topic'
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

  #my_post will now belong to my_topic
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }

  context "guest user" do
    describe "GET show" do
      #we pass {id: my_post.id} to show as a parameter. These parameters are passed to the  params hash
      it "returns http success" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end

      # expect the response to return the 'show' view
      it "renders the #show view" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end

      # expect the post to equal my_post because we call 'show' with the id of  my_post
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(assigns(:post)).to eq(my_post)
      end
    end

    describe "Get new" do
      it "returns http redirect if user isn't signed in but tries to create new post" do
        get :new, topic_id: my_topic.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect if user isn't signed in" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect if user isn't signed in and tries to edit" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect if user isn't signed in and tries to update post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect if user isn't signed in and tries to delete post" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context "signed-in user" do
    before do
      create_session(my_user)
    end

    describe "GET show" do
      #we pass {id: my_post.id} to show as a parameter. These parameters are passed to the  params hash
      it "returns http success" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end

      # expect the response to return the 'show' view
      it "renders the #show view" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :show
      end

      # expect the post to equal my_post because we call 'show' with the id of  my_post
      it "assigns my_post to @post" do
        get :show, topic_id: my_topic.id, id: my_post.id
        expect(assigns(:post)).to eq(my_post)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end

      # use the render_template method to verify that the correct template (view) is rendered.
      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end

      # expect the @post instance variable to be initialized by PostsController#new
      it "instantiates @post" do
        get :new, topic_id: my_topic.id
        expect(assigns(:post)).not_to be_nil
      end
    end

    describe "POST create" do

      # Post instances (i.e. rows in the posts table) in the database will increase by one.
      it "increases the number of Post by 1" do
        expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end

      it "assigns the new post to @post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end

      it "redirects to the new post" do
        post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, Post.last]
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        expect(response).to render_template :edit
      end

      it "assigns post to be updated to @post" do
        get :edit, topic_id: my_topic.id, id: my_post.id
        post_instance = assigns(:post)

        expect(post_instance.id).to eq my_post.id
        expect(post_instance.title).to eq my_post.title
        expect(post_instance.body).to eq my_post.body
      end
    end

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}

        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end

      #redirect to the posts 'show' view
      it "redirects to the updated post" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_topic, my_post]
      end
    end

    describe "DELETE destroy" do
      it "deletes the post" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id

        count = Post.where({id: my_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        delete :destroy, topic_id: my_topic.id, id: my_post.id

        expect(response).to redirect_to my_topic
      end
    end
  end
end
