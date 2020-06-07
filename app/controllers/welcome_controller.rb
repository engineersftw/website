class WelcomeController < ApplicationController
  def index
    @featured_videos = FeaturedVideo.active.order('sequence ASC').map{ |f| f.episode }
    @videos = Episode.active.limit(6).order('published_at DESC')
    @events = get_events
  end

  def conferences
    conference_category = 1
    @conferences = Playlist.where(playlist_category_id: conference_category).where(active: true).order('publish_date DESC')
  end

  def events
    @events = get_events
  end

  def screenshots
    @screenshots_base_url = ENV['SCREENSHOT_SVC_BASE_URL']
  end

  def goto_playlist
    redirect_to 'http://j.mp/sgmeetups'
  end

  def cal
    render inline: WebuildEventsService.new.fetch_cal, content_type: "text/calendar"
  end

  def support_us
    @stripe_publishable_key = ENV['STRIPE_PUBLISHABLE_KEY']
    @support_plans = STRIPE_SUPPORT_PLANS
  end

  def terms; end

  private

  def get_events
    WebuildEventsService.new.parse_events
  end
end
