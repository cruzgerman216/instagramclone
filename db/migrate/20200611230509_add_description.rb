class AddDescription < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :post
    add_column :posts, :description, :string
  end
end
