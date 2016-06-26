class EpisodesController < ApplicationController
  def index
    @episodes = Episode.active.tagged_with(params[:tag]) if params[:tag]
    @episodes ||= Episode.acive.all
    @current_page = (params[:page] || 1).to_i
    @episodes = @episodes.active.order('published_at DESC').page(@current_page)
    @total_records = @episodes.total_count
  end

  def playlist
    @playlist = is_number?(params[:id]) ? Playlist.find(params[:id]) : Playlist.find_by_slug(params[:id])
    @episodes = @playlist.playlist_items.order('sort_order ASC').map(&:episode).select{|episode| episode.active? }
  end

  def search
    @search = search_param[:search]
    @episodes = @search.present? ? Episode.active.where("lower(title) like :term or lower(description) like :term", {term: "%#{@search.downcase}%"}).order('published_at DESC') : []
  end

  def show
    @video = Episode.active.find(params[:id])
  end

  def alias
    @video = Episode.active.find(params[:id])
    redirect_to video_slug_path(title: @video.title.parameterize, id: @video.id)
  end

  private

  def search_param
    params.permit(:search)
  end

  def is_number?(string)
    no_commas =  string.gsub(',', '')
    matches = no_commas.match(/-?\d+(?:\.\d+)?/)
    if !matches.nil? && matches.size == 1 && matches[0] == no_commas
      true
    else
      false
    end
  end
end
