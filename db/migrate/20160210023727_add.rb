class Add < ActiveRecord::Migration
  def change
    add_column :episodes, :active, :boolean, null: false, default: true
  end
end
