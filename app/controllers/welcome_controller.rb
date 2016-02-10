class WelcomeController < ApplicationController
  def index
    @videos = Episode.active.limit(6).order('published_at DESC')
  end

  def conferences
    conference_category = 1
    @conferences = Playlist.where(playlist_category_id: conference_category).where(active: true).order('publish_date DESC')
  end

  def live
    render layout: 'live'
  end

  def goto_playlist
    redirect_to 'http://j.mp/sgmeetups'
  end
end
