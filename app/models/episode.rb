class Episode < ActiveRecord::Base
  has_many :playlist_items
  has_many :playlists, through: :playlist_items
  has_many :video_organizations
  has_many :organizations, through: :video_organizations
  has_many :video_presenters
  has_many :presenters, through: :video_presenters

  accepts_nested_attributes_for :video_organizations, allow_destroy: true
  accepts_nested_attributes_for :video_presenters, allow_destroy: true
end
