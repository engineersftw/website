class VideoPresenter < ActiveRecord::Base
  belongs_to :episode
  belongs_to :presenter

  validates :episode, :presenter, presence: true
end
