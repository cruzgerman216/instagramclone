class DropFollowerAgain < ActiveRecord::Migration[5.2]
  def change
    drop_table :followers
    create_table :follows do |t|
      t.integer "user_id"
      t.integer "following_id"
    end
  end
end
