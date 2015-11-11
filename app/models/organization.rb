class Organization < ActiveRecord::Base
  has_many :video_organizations
  has_many :episodes, through: :video_organizations
end
