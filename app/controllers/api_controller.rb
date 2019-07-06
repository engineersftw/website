 class ApiController < ApplicationController
  PER_PAGE = 50

  def organizations
    @organizations = Organization.order('title ASC')
  end

  def organization
    @organization = is_number?(params[:id]) ? Organization.find(params[:id]) : Organization.find_by_slug(params[:id])
  end

  def organization_videos
    organization = is_number?(params[:id]) ? Organization.find(params[:id]) : Organization.find_by_slug(params[:id])
    @current_page = (params[:page] || 1).to_i
    @per_page = (params[:per_page] || PER_PAGE).to_i
    @videos = organization.episodes.active.order('published_at DESC').page(@current_page).per(@per_page)
    @total_records = @videos.total_count
  end

  def presenters
    @presenters = Presenter.order('name ASC')
  end

  def events
    render json: WebuildEventsService.new.fetch_events
  end
end
