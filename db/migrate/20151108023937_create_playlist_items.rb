class CreatePlaylistItems < ActiveRecord::Migration
  def change
    create_table :playlist_items do |t|
      t.references :playlist, index: true, null: false
      t.references :episode, index: true, null: false
      t.integer :sort_order, index: true

      t.timestamps null: false
    end
  end
end
