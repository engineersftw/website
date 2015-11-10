class WelcomeController < ApplicationController
  layout 'conferences', only: [:conferences]

  def index
    @recent_episodes = Episode.limit(8).order('published_at DESC')
  end

  def conferences
    @conferences = Playlist.where("playlist_id != ?", 'PLECEw2eFfW7hYMucZmsrryV_9nIc485P1').where(active: true).order('publish_date DESC')
  end

  def goto_playlist
    redirect_to 'http://j.mp/sgmeetups'
  end
end
