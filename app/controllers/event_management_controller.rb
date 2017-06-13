class EventManagementController < ApplicationController
  before_action :webuild_events, only: [:new, :create]
  def index
    @events = Event.where("start_time > ?", DateTime.now.beginning_of_day)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    webuild_event = webuild_events.find{ |e| e['id'] == @event.webuild_id }

    unless webuild_event.nil?
      @event = Event.new(event_params.merge(webuild_event.except!('rsvp_count', 'formatted_time')))
    end

    if @event.save
      flash[:success] = 'Event Created'
      redirect_to event_management_index_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit(:webuild_id)
  end

  def webuild_events
    @webuild_events ||= WebuildEventsService.new.get_events
  end
end
