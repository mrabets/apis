class AddDefaultValueToLikedAttribute < ActiveRecord::Migration[6.1]
  def change
    change_column :likes, :liked, :boolean, default: true
  end
end
