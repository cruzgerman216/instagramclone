class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
    end
  end
end
# rake db:migrate:redo VERSION=20100421175455