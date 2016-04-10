require "rails_helper"

describe Post do
  
  it "returns chronological posts" do
    post1 = create(:post, text: "first post")
    post2 = create(:post, text: "second post")
    post3 = create(:post, text: "third post")

    expect(Post.all).to eq [post3, post2, post1]

  end

  it "has a minimum length restriction" do
    post = build(:post, text: "1")

    expect(post).not_to be_valid
  end

  it "has a maximum length restriction" do
    post = build(:post, text: "x" * 1000)

    expect(post).not_to be_valid
  end

end