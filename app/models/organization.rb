class Organization < ApplicationRecord
  has_many :video_organizations, dependent: :destroy
  has_many :episodes, through: :video_organizations
end
