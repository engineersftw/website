class AddMetaToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :website, :string
    add_column :playlists, :hashtag, :string
  end
end
