class DropAccount < ActiveRecord::Migration[5.2]
  def change
    remove_column :followers, :account_id
  end
end
