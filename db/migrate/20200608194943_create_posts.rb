class CreatePosts < ActiveRecord::Migration[5.2]
    def change
    create_table :posts do|t|
      t.string :post
      t.integer :user_id
      t.integer :comment_id
    end
    create_table :comments do|t|
      t.string :comment
      t.integer :post_id
      t.integer :user_id
    end
  end
end
