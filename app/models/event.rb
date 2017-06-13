class Event < ActiveRecord::Base
  validates_presence_of :webuild_id, :group_id, :platform
end
