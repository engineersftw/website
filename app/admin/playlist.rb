ActiveAdmin.register Playlist do
  permit_params :id, :playlist_id, :name, :description, :publish_date, :active

  config.sort_order = 'publish_date_desc'

  filter :name
  filter :description

  index do
    id_column
    column :publish_date
    column :playlist_category
    column 'Thumbnail' do |org|
      image_tag org.image, width: 150
    end
    column :name
    column :active
    actions
  end
end
