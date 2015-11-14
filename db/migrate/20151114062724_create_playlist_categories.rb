class CreatePlaylistCategories < ActiveRecord::Migration
  def change
    create_table :playlist_categories do |t|
      t.string :title
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
