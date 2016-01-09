class AddAvatarUrlToPresenters < ActiveRecord::Migration
  def change
    add_column :presenters, :avatar_url, :string, null: true
  end
end
