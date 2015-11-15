class AddBylineToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :byline, :string
  end
end
