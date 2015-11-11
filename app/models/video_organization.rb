class VideoOrganization < ActiveRecord::Base
  belongs_to :episode
  belongs_to :organization
end
