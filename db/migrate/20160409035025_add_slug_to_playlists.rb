class AddSlugToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :slug, :string, index:true, null: true
  end
end
