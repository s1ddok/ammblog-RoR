require "rails_helper"

describe RelationsController, "follow/unfollow user" do
  login_user

  describe "create" do
    let!(:user_to_follow) { create(:user) }

    it "receives notification and redirects to timeline" do

      expect { 
        post :create, followed_id: user_to_follow.id
      }.to change(Relation, :count).by(1)

      expect(flash[:notice]).to include(user_to_follow.username)

      expect(subject).to redirect_to(user_timeline_path(user_to_follow.username))

    end

  end

  describe "destroy" do
    let!(:user_to_follow) { create(:user) }

    it "receives notification and redirects to profile" do

      expect { 
        post :create, followed_id: user_to_follow.id
      }.to change(Relation, :count).by(1)

      expect { 
        delete :destroy, id: user_to_follow.id
      }.to change(Relation, :count).by(-1)
    
      expect(flash[:notice]).to include(user_to_follow.username)
    
      expect(subject).to redirect_to(user_timeline_path(user_to_follow.username))

    end

  end

  describe "update" do

    it "updated the last seen date" do 

      patch :update

      expect(subject.current_user.followers_check_timestamp).to be > (Time.now - 10.seconds)

      expect(response.status).to eq 200

    end

  end

end