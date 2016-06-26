ActiveAdmin.register FeaturedVideo do
  permit_params :id, :episode_id, :sequence, :active

  config.filters = false
  config.sort_order = 'sequence_asc'
  sortable tree: false, sorting_attribute: :sequence

  index do
    selectable_column
    column 'Thumbnail' do |featured|
      image_tag featured.episode.image1
    end
    column 'Video' do |featured|
      link_to featured.episode.title, admin_episode_path(featured.episode)
    end
    column :sequence
    column :active
    actions
  end

  index as: :sortable do
    label do |t|
      "#{t.episode.title}"
    end
    actions
  end

  form do |f|
    f.inputs 'Featured Video' do
      f.input :episode_id, as: :select, collection: Episode.all, input_html: { class: 'chosen-select' }
      f.input :sequence
      f.input :active
    end
    f.actions
  end
end
