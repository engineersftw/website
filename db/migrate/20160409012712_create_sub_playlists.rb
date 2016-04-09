class CreateSubPlaylists < ActiveRecord::Migration
  def change
    create_table :sub_playlists do |t|
      t.integer :playlist_id, index: true, null: false
      t.integer :sub_playlist_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
