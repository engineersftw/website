class AddVideoTypeToVideo < ActiveRecord::Migration
  def change
    add_column :episodes, :video_site, :integer, default: 1, null: false
  end
end
