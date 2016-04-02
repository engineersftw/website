class WebuildEventsService
  def get_events(event_url='https://webuild.sg/api/v1/events')
    begin
      response = RestClient.get event_url
      response_json = JSON.parse(response.body)
      response_json["events"]
    rescue
      []
    end
  end
end