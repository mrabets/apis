class AddLikedToLike < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :liked, :boolean 
  end
end
