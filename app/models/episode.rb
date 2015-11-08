class Episode < ActiveRecord::Base
  has_many :playlist_items
  has_many :playlists, through: :playlist_items
end
