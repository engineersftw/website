ActiveAdmin.register Organization do
  permit_params :id, :title, :description, :website, :twitter, :contact_person, :image, :active

  filter :title
  filter :description
  filter :contact_person
  filter :website

  index do
    id_column
    column 'Logo' do |org|
      image_tag org.image, width: 150
    end
    column :title
    column :twitter
    column 'Website' do |org|
      link_to org.website, org.website
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
