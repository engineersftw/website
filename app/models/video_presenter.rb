class VideoPresenter < ApplicationRecord
  belongs_to :episode
  belongs_to :presenter

  validates :episode, :presenter, presence: true
end
