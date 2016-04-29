ActiveAdmin.register Playlist do
  permit_params :id, :playlist_category_id, :playlist_id, :name, :description, :website, :hashtag, :slug, :image, :publish_date, :active

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

  form do |f|
    f.inputs 'Playlist' do
      f.input :playlist_category_id, as: :select, collection: PlaylistCategory.all
      f.input :playlist_id
      f.input :name
      f.input :description
      f.input :image
      f.input :website
      f.input :slug
    end
    f.actions
  end
end
