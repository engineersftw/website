class VideoPresenter < ActiveRecord::Base
  belongs_to :episode
  belongs_to :presenter
end
