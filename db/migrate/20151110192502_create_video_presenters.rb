class CreateVideoPresenters < ActiveRecord::Migration
  def change
    create_table :video_presenters do |t|
      t.references :episode, index: true, foreign_key: true
      t.references :presenter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
