class AddOrderColumn < ActiveRecord::Migration
  def change
    add_column :episodes, :sort_order, :integer
  end
end
