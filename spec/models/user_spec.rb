require "rails_helper"

describe User do
  
  it "has default values" do
    user = create(:user)

    expect(user.followers_check_timestamp).not_to be nil

  end

  it "searches and return users" do 
    
    5.times do |n| create(:user, username: "user#{n}") end

    result = User.search("user")

    expect(result.length).to be 5

    result = User.search("1")

    expect(result.length).to be 1

  end

  it "has username minimum length restriction" do
    user = build(:user, username: "1")

    expect(user).not_to be_valid
  end

  it "has username maximum length restriction" do
    user = build(:user, username: "x" * 1000)

    expect(user).not_to be_valid
  end

end