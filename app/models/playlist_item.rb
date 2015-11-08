class PlaylistItem < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :episode
end
