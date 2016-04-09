ActiveAdmin.register Playlist do
  permit_params :id, :playlist_category_id, :playlist_id, :name, :description, :website, :hashtag, :image, :publish_date, :active

  config.sort_order = 'publish_date_desc'

  filter :name
  filter :description

  index do
    id_column
    column :publish_date
    column :playlist_category
    column 'Thumbnail' do |pl|
      image_tag pl.image, width: 150
    end
    column :name
    column :active
    actions
  end
end
