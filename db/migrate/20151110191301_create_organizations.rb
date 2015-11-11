class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :title, null: false
      t.text :description
      t.string :website
      t.string :twitter, index: true
      t.string :contact_person
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
