ActiveAdmin.register Organization do
  permit_params :id, :title, :description, :website, :twitter, :contact_person, :image, :active
  config.sort_order = 'title_asc'

  filter :title
  filter :description
  filter :contact_person
  filter :website

  batch_action :merge, form: -> {
    {
      merge_with: Organization.order('title ASC').pluck(:title, :id),
      remove_merged: :checkbox
    }
  } do |ids, inputs|
    merge_id = inputs[:merge_with].to_i
    remove_merged = (inputs[:remove_merged] == 'on')

    affected_videos = VideoOrganization.where(organization_id: ids)
    affected_videos.each do |video_org|
      if video_org.episode.video_organizations.map(&:organization_id).include?(merge_id)
        video_org.destroy
      else
        video_org.update(organization_id: merge_id)
      end
    end

    batch_action_collection.find(ids).each do |organization|
      if remove_merged
        organization.destroy
      else
        organization.update(active: false)
      end
    end

    redirect_to collection_path, alert: "Organizations have been merged."
  end

  index do
    selectable_column
    id_column
    column 'Logo' do |org|
      image_tag org.image, width: 150
    end
    column :title
    column :twitter
    column 'Website' do |org|
      link_to org.website, org.website if org.website.present?
    end
    column :contact_person
    column :active
    actions
  end

  show do
    tabs do
      tab 'Organization Detail' do
        attributes_table do
          row('Logo') { |v| image_tag v.image }
          row :title
          row('Description') { |v| simple_format(v.description) }
          row :twitter
          row :website
          row :contact_person
          row :active
        end
      end
      tab 'Videos' do
        panel 'Videos' do
          table_for organization.episodes do
            column :published_at
            column 'Thumbnail' do |video|
              image_tag video.image1
            end
            column('Title') do |video|
              link_to video.title, admin_episode_path(video)
            end
            column('Actions') do |video|
              links = []
              links << link_to('View', admin_episode_path(video))
              links << link_to('Edit', edit_admin_episode_path(video))

              links.join(' | ').html_safe
            end
          end
        end
      end
    end
  end
end
