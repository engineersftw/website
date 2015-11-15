ActiveAdmin.register Presenter do
  permit_params :id, :name, :byline, :biography, :twitter, :email, :website, :active

  filter :name
  filter :byline
  filter :biography
  filter :twitter
  filter :email

  index do
    id_column
    column 'Avatar' do |p|
      image_tag p.avatar, width: 73 if p.avatar.present?
    end
    column :name
    column :byline
    column :twitter
    column 'Website' do |p|
      link_to p.website, p.website if p.website.present?
    end
    column :active
    actions
  end

  show do
    tabs do
      tab 'Presenter Details' do
        attributes_table do
          row('Avatar') { |v| image_tag v.avatar }
          row :name
          row :byline
          row :twitter
          row :email
          row :website
          row('Biography') { |v| simple_format(v.biography) }
          row :active
        end
      end
      tab 'Videos' do
        panel 'Videos' do
          table_for presenter.episodes do
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
