class CreateVideoLinks < ActiveRecord::Migration
  def change
    create_table :video_links do |t|
      t.string :title
      t.string :url
      t.references :episode, index: true, foreign_key: true
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
