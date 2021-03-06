require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_topic) { create(:topic) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }

  # redirecting guests if they attempt to favorite a post.
  context "guest user" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, {post_id: my_post.id}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'redirects the user to the sign in view' do
        favorite = my_user.favorites.where(post: my_post).create
        delete :destroy, { post_id: my_post.id, id: favorite.id }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      create_session(my_user)
    end
    # after a user favorites a post, we redirect them back to the post's show view
    describe "POST create" do
      it "redirects to the posts show view" do
        post :create, { post_id: my_post.id}
        expect(response).to redirect_to([my_topic, my_post])
      end

      it "creates a favorite for the current use and specified post" do
        # expect that no favorites exist
        expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
        post :create, { post_id: my_post.id }
        # will have a favorite associated with that post.
        expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
      end
    end

    describe 'DELETE destroy' do
      it 'redirects to the posts show view' do
        favorite = my_user.favorites.where(post: my_post).create
        delete :destroy, { post_id: my_post.id, id: favorite.id }
        expect(response).to redirect_to([my_topic, my_post])
      end

      it 'destroys the favorite for the current user and post' do
        favorite = my_user.favorites.where(post: my_post).create
        # before delete
        expect( my_user.favorites.find_by_post_id(my_post.id) ).not_to be_nil
        delete :destroy, { post_id: my_post.id, id: favorite.id }
        # after delete
        expect( my_user.favorites.find_by_post_id(my_post.id) ).to be_nil
      end
    end
  end
end
