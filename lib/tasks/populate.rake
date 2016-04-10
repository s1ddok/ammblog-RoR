namespace :db do
  desc "Clear database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    suckr = ImageSuckr::GoogleSuckr.new

    [Relation, Post, User].each(&:delete_all)

    TOTAL_USERS = 30
    POSTS_RANGE = 5..30
    FOLLOWING_COUNT = 1..15

    ids = Array.new
    pairs = Array.new

    TOTAL_USERS.times do |u|

      begin

        user = User.create!(
          username: Faker::Internet.user_name(5..10),
          password: "xxxxxxxx",
          encrypted_password: "xxxxxxxx",
          email: Faker::Internet.email,
          sign_in_count: 0
        )

        ids << user.id

        rand(POSTS_RANGE).times do |p|
          Post.create!(
            user_id: user.id,
            text: Faker::Lorem.sentence(5, 25),
            created_at: Faker::Date.between(10.days.ago, Date.today)
          )
        end

      rescue
        # do nothing, sometimes the suckr raises 404 exception
      end

    end

    # at least a pair
    if ids.count > 2

      # each user has around 1 to 15 followers
      ids.each do |id| rand(FOLLOWING_COUNT).times do

          pair = [id, ids[rand(ids.count)]]

          # avoids same user and repetitions
          if !pairs.include?(pair) and pair[0] != pair[1]

            relation = Relation.create!(
              follower_id: pair[0],
              followed_id: pair[1]
              )

            pairs << pair

          end

        end

      end

    end

  end

end
