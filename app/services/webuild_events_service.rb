class WebuildEventsService
  def get_events(event_url='https://webuild.sg/api/v1/events')
    begin
      Rails.cache.fetch('all_events') do
        response = RestClient.get event_url
        response_json = JSON.parse(response.body)
        response_json["events"]
      end
    rescue
      []
    end
  end
end