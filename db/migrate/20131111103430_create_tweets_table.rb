class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :message
      t.string :hashtags
      t.string :type
      t.references :user
      t.references :category

      t.timestamp
    end
  end
end
