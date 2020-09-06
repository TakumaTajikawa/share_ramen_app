class RemovePrefectureFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :prefecture, :string
  end
end
