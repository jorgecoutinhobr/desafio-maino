require 'rails_helper'

RSpec.describe "/posts", type: :request do
  describe "GET /index" do
    let!(:post) { create(:post) }

    context "success" do
      before {  get posts_path }

      it 'returns a 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @posts' do
        expect(Post.all).to eq([post])
      end
    end
  end

  describe "GET /new" do
    let!(:user) { create(:user) }

    context "success" do
      before do
        login_as(user)
        get new_post_path
      end

      it 'returns a 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "failure" do
      before do
        get new_post_path
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /create" do
    let!(:user) { create(:user) }

    context "success" do
      before do
        login_as(user)
        post posts_path, params: { post: attributes_for(:post) }
      end

      it 'creates a post' do
        expect(Post.count).to eq(1)
      end
    end

    context "failure" do
      before do
        login_as(user)
        post posts_path
      end

      it 'not creates a post without params' do
        expect(Post.count).to eq(0)
      end
    end
  end
end
