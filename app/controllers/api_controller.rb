 class ApiController < ApplicationController
  def organizations
    @organizations = Organization.order('title ASC')
  end

  def presenters
    @presenters = Presenter.order('name ASC')
  end

  def events
    render json: WebuildEventsService.new.fetch_events
  end
end
