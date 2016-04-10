require "rails_helper"

describe PostsController, "logged user" do
  login_user

  describe "create" do
    let(:posts) { attributes_for(:post) }

    it "creates a post and redirects to root" do
      expect {
        post :create, post: posts
      }.to change(Post, :count).by(1)

      expect(flash[:notice]).to eq I18n.t(:post_success)
      expect(subject).to redirect_to(root_path)
    end
  end

  describe "delete" do
    let!(:post) { create(:post, user: subject.current_user) }

    it "deletes the post and redirects to root" do
      expect {
        delete :destroy, id: post.id
      }.to change(Post, :count).by(-1)

      expect(flash[:notice]).to eq I18n.t(:post_success_delete)
      expect(subject).to redirect_to(root_path)
    end

  end

end