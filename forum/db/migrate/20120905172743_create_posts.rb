class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text
      t.datetime :posted_on
      t.integer :poster_id
      t.references :topic

      t.timestamps
    end
    add_index :posts, :topic_id
  end
end
