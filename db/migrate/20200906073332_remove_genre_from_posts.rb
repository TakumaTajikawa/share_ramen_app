class RemoveGenreFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :genre, :string
  end
end
