class EpisodesController < ApplicationController
  def index
    @episodes = Episode.all.order('published_at DESC')
    @total_records = @episodes.count

    if params[:page]
      @current_page = params[:page]
      @episodes = @episodes.page(@current_page)
      @total_records = @episodes.total_count
    end
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
