class VideoOrganization < ActiveRecord::Base
  belongs_to :episode
  belongs_to :organization

  validates :episode, :organization, presence: true
end
