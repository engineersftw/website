class AddCategoryToPlaylists < ActiveRecord::Migration
  def change
    add_reference :playlists, :playlist_category, index: true
  end
end
