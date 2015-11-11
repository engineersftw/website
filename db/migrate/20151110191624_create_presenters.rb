class CreatePresenters < ActiveRecord::Migration
  def change
    create_table :presenters do |t|
      t.string :name, null: false
      t.text :biography
      t.string :twitter, index: true
      t.string :email
      t.string :website
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
