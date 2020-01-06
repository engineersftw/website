class Playlist < ApplicationRecord
  has_many :playlist_items
  has_many :episodes, through: :playlist_items
  has_many :sub_playlists
  belongs_to :playlist_category

  scope :active, -> { where(active: true) }

  def conference_tracks
    sub_playlists.order(:sequence).includes(:sub_playlist).map{ |spl| spl.sub_playlist }
  end
end
