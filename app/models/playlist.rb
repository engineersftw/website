class Playlist < ActiveRecord::Base
  has_many :playlist_items
  has_many :episodes, through: :playlist_items

  scope :active, -> { where(active: true) }
end
