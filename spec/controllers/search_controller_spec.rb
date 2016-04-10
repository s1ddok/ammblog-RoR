require "rails_helper"

describe SearchController, "search users" do
  login_user

  describe "index" do
    let!(:user1) { create(:user, username: "new_user1" ) }
    let!(:user2) { create(:user, username: "new_user2" ) }

    it "shows a empty list" do
      
      get "index"

      expect(assigns(:users)).to eq nil

    end

    it "finds a user" do

      get :index, user: { username: "new_user1" }

      expect(assigns(:users)).not_to eq nil

      expect(assigns(:users).length).to eq 1

    end

    it "doesn't find anyone with invalid data" do

      get :index, user: { username: "xxxxx" }

      expect(assigns(:users)).not_to eq nil

      expect(assigns(:users).length).to eq 0

    end

  end

end