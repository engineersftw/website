class WelcomeController < ApplicationController
  def index
    @first_video = Episode.limit(1).order(:sort_order).first
    @recent_episodes = Episode.limit(8).offset(1).order(:sort_order)
  end

  def goto_playlist
    redirect_to 'http://j.mp/sgmeetups'
  end
end
