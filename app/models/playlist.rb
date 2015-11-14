class Playlist < ActiveRecord::Base
  has_many :playlist_items
  has_many :episodes, through: :playlist_items
  belongs_to :playlist_category

  scope :active, -> { where(active: true) }
end
