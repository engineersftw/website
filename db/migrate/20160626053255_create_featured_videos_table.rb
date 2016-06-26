class CreateFeaturedVideosTable < ActiveRecord::Migration
  def change
    create_table :featured_videos do |t|
      t.integer :episode_id, null: false
      t.integer :sequence, default: 0, null: false
      t.boolean :active, default: true, null: false
    end
  end
end
