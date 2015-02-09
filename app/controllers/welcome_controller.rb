class WelcomeController < ApplicationController
  before_filter :set_nav, except: [:goto_playlist]
  attr_accessor :active_index, :active_about, :active_events

  def set_nav
    self.send("active_#{params[:action]}=", 'active')
  end

  def goto_playlist
    redirect_to 'http://j.mp/sgmeetups'
  end
end
