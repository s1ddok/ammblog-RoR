class AddFollowersCheckTimestampToUser < ActiveRecord::Migration
  def change
    add_column :users, :followers_check_timestamp, :timestamp
  end
end
