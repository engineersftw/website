class PlaylistCategory < ActiveRecord::Base
  has_many :playlists
end
