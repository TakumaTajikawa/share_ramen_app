class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :store
      t.string :prefecture
      t.string :genre
      t.string :ramen
      t.string :image
      t.text :impression
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
