class CreateHearts < ActiveRecord::Migration[5.2]
  def change
    create_table :hearts do|t|
      t.integer :post_id
      t.integer :user_id
    end
  end
end
