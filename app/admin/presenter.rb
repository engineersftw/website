ActiveAdmin.register Presenter do
  permit_params :id, :name, :biography, :twitter, :email, :website, :active
end
