class Episode < ApplicationRecord
  acts_as_taggable

  enum video_site: { youtube: 1, vimeo: 2 }

  has_many :playlist_items, dependent: :destroy
  has_many :playlists, through: :playlist_items
  has_many :video_organizations, dependent: :destroy
  has_many :organizations, through: :video_organizations
  has_many :video_presenters, dependent: :destroy
  has_many :presenters, through: :video_presenters
  has_many :video_links, dependent: :destroy
  has_many :featured_videos, dependent: :destroy

  accepts_nested_attributes_for :video_organizations, allow_destroy: true
  accepts_nested_attributes_for :video_presenters, allow_destroy: true
  accepts_nested_attributes_for :video_links, allow_destroy: true

  scope :active, -> { where(active: true) }

  before_validation :pull_video_info

  def pull_video_info
    if video_id.present? && video_site.present? && title.blank?
      if (video_site == 'vimeo')
        video_info = VimeoService.new.get_video(video_id)
      elsif (video_site == 'youtube')
        video_info = YoutubeService.new(access_token: ENV["YOUTUBE_ACCESS_TOKEN"], refresh_token: ENV["YOUTUBE_REFRESH_TOKEN"]).get_video(video_id)
      end

      if video_info.present?
        assign_attributes(
          title: video_info.title,
          published_at: video_info.published_at,
          description: video_info.description,
          image1: video_info.image1,
          image2: video_info.image2,
          image3: video_info.image3
        )
      end
    end
  end

end
