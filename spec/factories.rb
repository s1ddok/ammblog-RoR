FactoryGirl.define do

  factory :user, aliases: [:follower, :followed] do |f|

    # fields
    f.sequence :email do |n| 
      "email#{n}@hedeveloper.com"
    end 
    f.sequence :username do |n| 
      "user#{n}"
    end 
    f.password "fakepassword"
    f.password_confirmation "fakepassword"

    f.followers_check_timestamp { Time.now - 5.days }

  end

  factory :post do |f|
    user
    
    f.text "fake post text"

    factory :invalid_post do |f|
      f.text nil
    end

  end

end

# create(:user).posts.length # 0
# create(:user_with_posts).posts.length # 5
# create(:user_with_posts, posts_count: 15).posts.length # 15