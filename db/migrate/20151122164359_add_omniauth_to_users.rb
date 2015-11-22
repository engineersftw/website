class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, index: true, null: true
    add_column :users, :uid, :string, index: true, null: true
    add_column :users, :twitter, :string, index: true, null: true
  end
end
