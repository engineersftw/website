class VideoOrganization < ApplicationRecord
  belongs_to :episode
  belongs_to :organization

  validates :episode, :organization, presence: true
end
