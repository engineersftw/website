class EpisodesController < ApplicationController
  def index
    @episodes = Episode.all.order(:sort_order)
  end

  def show
    @video = Episode.find_by(video_id: params[:id])
  end
end
