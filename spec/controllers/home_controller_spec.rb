require "rails_helper"

describe HomeController do

  describe "logged user visit" do 
    login_user
    before { get :index }

    describe "timeline" do

      it "should have a logged user" do
        expect(assigns(:current_user)).not_to be_nil
      end

      it "should be logged user's timeline" do
        expect(assigns(:timeline_user)).to eq(assigns(:current_user)) 
      end

      it "should show logged user's posts" do
        expect(assigns(:latest_posts)).not_to be_nil
      end

      it "should be a success" do
        expect(response).to be_success
      end

    end

  end

  describe "new user visit" do 
    before { get :index }

    describe "timeline" do

      it "doen't have a logged user" do
        expect(assigns(:current_user)).to be_nil
      end

      it "doesn't belong to anyone" do
        expect(assigns(:timeline_user)).to be_nil
      end

      it "shows random posts" do
        expect(assigns(:latest_posts)).not_to be_nil
      end

      it "should be a success" do
        expect(response).to be_success
      end

    end

  end

end