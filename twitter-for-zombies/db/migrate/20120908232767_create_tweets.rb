class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :status
      t.references :zombie

      t.timestamps
    end
    add_index :tweets, :zombie_id
  end
end
