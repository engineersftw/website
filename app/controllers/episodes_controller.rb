class EpisodesController < ApplicationController
  layout 'video', only: [:show]
  layout 'playlist', only: [:playlist]

  def index
    @episodes = Episode.all.order('published_at DESC')
  end

  def playlist
    @playlist = Playlist.find(params[:id])
    @episodes = @playlist.playlist_items.order('sort_order ASC').map(&:episode)
  end

  def search
    @search = search_param[:search]
    @episodes = @search.present? ? Episode.where("lower(title) like :term or lower(description) like :term", {term: "%#{@search.downcase}%"}).order(:sort_order) : []
  end

  def show
    @video = Episode.find(params[:id])
  end

  private

  def search_param
    params.permit(:search)
  end
end
