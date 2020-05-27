class AddPasswordsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_digest, :string
  end
end

# rake db:migrate:redo VERSION=20200526201533
