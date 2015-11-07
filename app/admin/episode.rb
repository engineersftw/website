ActiveAdmin.register Episode do
  permit_params :video_id, :title, :description, :published_at, :image1, :image2, :image3, :sort_order

  config.sort_order = 'sort_order_asc'

  filter :title
  filter :description

  index do
    id_column
    column :sort_order
    column 'Thumbnail' do |video|
      image_tag video.image1
    end
    column :title
    column :published_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs
    f.actions
  end
end
