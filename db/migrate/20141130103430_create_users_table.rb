class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :screen_name
      t.integer :followers
      t.integer :following
      t.integer :statuses_count

      t.timestamp
    end
  end
end
