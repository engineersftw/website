ActiveAdmin.register Playlist do
  permit_params :id, :playlist_id, :name, :description, :publish_date, :active
end
