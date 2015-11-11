ActiveAdmin.register Organization do
  permit_params :id, :title, :description, :website, :twitter, :contact_person, :image, :active
end
