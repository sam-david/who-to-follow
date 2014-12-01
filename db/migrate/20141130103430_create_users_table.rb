class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.integer :followers
      t.integer :statuses


      t.timestamp
    end
  end
end
