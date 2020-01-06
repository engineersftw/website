class FeaturedVideo < ApplicationRecord
  belongs_to :episode
  scope :active, -> { where(active: true) }
end
