class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.datetime :posted_on
      t.integer :poster_id

      t.timestamps
    end
  end
end
