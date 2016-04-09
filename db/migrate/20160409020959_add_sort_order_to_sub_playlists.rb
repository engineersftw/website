class AddSortOrderToSubPlaylists < ActiveRecord::Migration
  def change
    add_column :sub_playlists, :sequence, :integer, null: false, default: 1
  end
end
