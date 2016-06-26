class FeaturedVideo < ActiveRecord::Base
  belongs_to :episode
  scope :active, -> { where(active: true) }
end
