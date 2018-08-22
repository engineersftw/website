class WebuildEventsService
  def fetch_events
    Rails.cache.fetch('all_upcoming_events') do
      response = RestClient.get event_url
      response.body
    end
  end

  def parse_events
    begin
      response_txt = fetch_events
      response_json = JSON.parse(response_txt)

      response_json["events"]
    rescue => e
      []
    end
  end

  private

  def event_url
    ENV['WEBUILDSG_EVENT_URL'] || 'http://api-webuild.7e14.starter-us-west-2.openshiftapps.com/events'
  end
end