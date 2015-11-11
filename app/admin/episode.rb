ActiveAdmin.register Episode do
  permit_params :video_id, :title, :description, :published_at, :image1, :image2, :image3, :sort_order, video_organizations_attributes: [:id, :organization_id, :_destroy],
    video_presenters_attributes: [:id, :presenter_id, :_destroy]

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
    panel 'YouTube Info' do
      attributes_table_for episode do
        row('Video ID') { |v| link_to v.video_id, "http://youtube.com/watch/?v=#{v.video_id}", target:'_blank' }
        row('Title') { |v| v.title }
        row('Description') { |v| simple_format(v.description) }
        row('Thumbnail') { |v| image_tag v.image2 }
        row('Published At') { |v| v.published_at.strftime('%e-%b-%Y %l:%M%P') }
      end
    end
    f.inputs 'Organizations' do
      f.has_many :video_organizations, allow_destroy: true do |o|
        o.input :organization, as: :select, collection: Organization.all, input_html: { class: 'chosen-select' }
      end
    end
    f.inputs 'presenter' do
      f.has_many :video_presenters, allow_destroy: true do |o|
        o.input :presenter, as: :select, collection: Presenter.all, input_html: { class: 'chosen-select' }
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row('Video ID') { |v| link_to v.video_id, "http://youtube.com/watch/?v=#{v.video_id}", target:'_blank' }
      row :title
      row('Description') { |v| simple_format(v.description) }
      row('Thumbnail') { |v| image_tag v.image2 }
      row('Published At') { |v| v.published_at.strftime('%e-%b-%Y %l:%M%P') }
    end
    panel 'Organizations' do
      table_for episode.organizations do
        column :title
        column :website
        column :twitter
      end
    end
    panel 'Presenters' do
      table_for episode.presenters do
        column :name
        column :website
        column :twitter
      end
    end
  end
end
