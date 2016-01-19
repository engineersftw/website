class EpisodesController < ApplicationController
  def index
    @current_page = (params[:page] || 1).to_i
    @episodes = Episode.all.order('published_at DESC').page(@current_page)
    @total_records = @episodes.total_count
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
