class AddSlugToOrganizationsTable < ActiveRecord::Migration
  def change
    add_column :organizations, :slug, :string, null: true
    add_index :organizations, :slug
  end
end
