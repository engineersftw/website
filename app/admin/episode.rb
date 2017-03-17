ActiveAdmin.register Episode do
  permit_params :id, :video_site, :video_id, :title, :description, :image1, :image2, :image3, :tag_list, :sort_order, :active, video_organizations_attributes: [:id, :organization_id, :_destroy],
    video_presenters_attributes: [:id, :presenter_id, :_destroy], video_links_attributes: [:id, :_destroy, :title, :url]

  config.sort_order = 'published_at_desc'

  filter :title
  filter :description

  batch_action :assign_organization_to, form: -> {
    {
        organization: Organization.order('title ASC').pluck(:title, :id),
    }
  } do |ids, inputs|
    organization_id = inputs[:organization].to_i

    batch_action_collection.find(ids).each do |episode|
      episode.video_organizations.where(organization_id: organization_id).first_or_create
    end

    redirect_to collection_path, alert: 'Episodes have been assigned an Organization.'
  end

  batch_action :assign_presenter_to, form: -> {
    {
        presenter: Presenter.order('name ASC').pluck(:name, :id),
    }
  } do |ids, inputs|
    presenter_id = inputs[:presenter].to_i

    batch_action_collection.find(ids).each do |episode|
      episode.video_presenters.where(presenter_id: presenter_id).first_or_create
    end

    redirect_to collection_path, alert: 'Episodes have been assigned a Presenter.'
  end

  index do
    selectable_column
    id_column
    column :published_at
    column :video_site
    column 'Thumbnail' do |video|
      image_tag video.image1
    end
    column :title
    column :active
    column 'Organizations' do |video|
      video.video_organizations.map do |video_org|
        link_to video_org.organization.title, admin_organization_path(video_org.organization)
      end.join(', ').html_safe
    end
    column 'Presenters' do |video|
      video.video_presenters.map do |video_presenter|
        link_to video_presenter.presenter.try(:name), admin_presenter_path(video_presenter.presenter)
      end.join(', ').html_safe
    end
    actions
  end

  form do |f|
    tabs do
      tab 'Video' do
        f.inputs do
          f.input :video_site, as: :select, collection: {youtube: 'youtube', vimeo: 'vimeo'}
          f.input :video_id, label: 'Video ID'
          f.input :title
          f.input :description
          f.input :active
        end
        f.inputs do
          f.input :image1
          f.input :image2
          f.input :image3
        end
      end
      tab 'Organization' do
        f.inputs do
          f.has_many :video_organizations, allow_destroy: true do |o|
            o.input :organization, as: :select, collection: Organization.all, input_html: { class: 'chosen-select' }
          end
        end
      end
      tab 'Presenter' do
        f.inputs do
          f.has_many :video_presenters, allow_destroy: true do |o|
            o.input :presenter, as: :select, collection: Presenter.all, input_html: { class: 'chosen-select' }
          end
        end
      end
      tab 'Links' do
        f.inputs do
          f.has_many :video_links, allow_destroy: true do |o|
            o.input :title
            o.input :url, label: 'URL'
            o.input :active
          end
        end
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :video_site
      row('Video ID') do |v|
        if v.video_site == 'youtube'
          link_to v.video_id, "http://youtube.com/watch/?v=#{v.video_id}", target:'_blank'
        else
          link_to v.video_id, "https://vimeo.com/#{v.video_id}", target:'_blank'
        end
      end
      row :title
      row('Description') { |v| simple_format(v.description) }
      row('Thumbnail') { |v| image_tag v.image2 }
      row('Tags') {|v| v.tag_list }
      row('Published At') { |v| v.published_at.strftime('%e-%b-%Y %l:%M%P') }
      row :active
    end
    panel 'Organizations' do
      table_for episode.organizations do
        column :title
        column('Website') { |v| link_to v.website, v.website, target: '_blank' }
        column :twitter
      end
    end
    panel 'Presenters' do
      table_for episode.presenters do
        column :name
        column('Website') { |v| link_to v.website, v.website, target: '_blank' }
        column :twitter
      end
    end
    panel 'Links' do
      table_for episode.video_links do
        column :title
        column('URL') { |v| link_to v.url, v.url, target: '_blank' }
      end
    end
  end
end
