class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :webuild_id, null: false
      t.string :group_id, null: false
      t.string :platform, null: false
      t.string :name, null: false
      t.text :description
      t.string :location
      t.string :url
      t.string :group_name
      t.string :group_url
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :latitude, precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10
      t.boolean :to_be_recorded, default: true
      t.timestamps null: false
    end

    add_index(:events, [:webuild_id, :group_id, :platform])
  end
end
