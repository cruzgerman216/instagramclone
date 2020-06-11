class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.integer "user_id"
      t.integer "account_id"
    end
  end
end
