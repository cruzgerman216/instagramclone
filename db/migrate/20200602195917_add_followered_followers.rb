class AddFolloweredFollowers < ActiveRecord::Migration[5.2]
  def change
    add_column :followers, :follower_id, :integer
    add_column :followers, :followed_id, :integer
  end
end
