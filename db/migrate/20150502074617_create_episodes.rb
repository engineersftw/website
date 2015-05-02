class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :video_id, index: true
      t.string :title
      t.datetime :published_at
      t.text :description
      t.string :image1
      t.string :image2
      t.string :image3

      t.timestamps null: false
    end
  end
end
