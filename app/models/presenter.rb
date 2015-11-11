class Presenter < ActiveRecord::Base
  has_many :video_presenters
  has_many :episodes, through: :video_presenters
end
