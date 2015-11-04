class EpisodesController < ApplicationController
  layout 'video', only: [:show]

  def index
    @episodes = Episode.all.order(:sort_order)
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
