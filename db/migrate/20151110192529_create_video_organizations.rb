class CreateVideoOrganizations < ActiveRecord::Migration
  def change
    create_table :video_organizations do |t|
      t.references :episode, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
