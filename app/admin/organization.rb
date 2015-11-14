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
end
