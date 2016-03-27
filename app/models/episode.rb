class Episode < ActiveRecord::Base
  acts_as_taggable

  has_many :playlist_items, dependent: :destroy
  has_many :playlists, through: :playlist_items
  has_many :video_organizations, dependent: :destroy
  has_many :organizations, through: :video_organizations
  has_many :video_presenters, dependent: :destroy
  has_many :presenters, through: :video_presenters
  has_many :video_links, dependent: :destroy

  accepts_nested_attributes_for :video_organizations, allow_destroy: true
  accepts_nested_attributes_for :video_presenters, allow_destroy: true
  accepts_nested_attributes_for :video_links, allow_destroy: true

  scope :active, -> { where(active: true) }

end
