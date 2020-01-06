class SubPlaylist < ApplicationRecord
  belongs_to :playlist
  has_one :sub_playlist, class_name: "Playlist", foreign_key: "id", primary_key: "sub_playlist_id"
end
