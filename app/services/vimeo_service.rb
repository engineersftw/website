class VimeoService
  ACCESS_KEY = ENV['VIMEO_BEARER_TOKEN']

  def get_video(video_id)
    video_url = "https://api.vimeo.com/videos/#{video_id}"
    response_json = make_api_call video_url

    Episode.new(
      video_site: 'vimeo',
      video_id: video_id,
      title: response_json[:name],
      published_at: response_json[:created_time],
      description: response_json[:description],
      image1: response_json[:pictures][:sizes][1][:link],
      image2: response_json[:pictures][:sizes][3][:link],
      image3: response_json[:pictures][:sizes][5][:link],
      view_count: response_json[:stats][:plays],
    )
  end

  def get_uploaded_videos
    video_url = 'https://api.vimeo.com/me/videos'
    items = []

    next_page_number = 1
    until next_page_number.nil?
      params = {
          page: next_page_number,
          per_page: 50
      }
      api_response = make_api_call video_url, params
      api_response[:data].each do |video_item|
        video_uri = /\/videos\/(?<video_id>\S*)/.match(video_item[:uri])

        if video_uri.nil?
          puts "Invalid URI: #{video_item[:uri]}"
          next
        end

        item = {
            video_id: video_uri[:video_id],
            title: video_item[:name],
            published_at: video_item[:created_time],
            description: video_item[:description],
            image1: video_item[:pictures][:sizes][1][:link],
            image2: video_item[:pictures][:sizes][3][:link],
            image3: video_item[:pictures][:sizes][5][:link],
            view_count: video_item[:stats][:plays],
        }
        items << item
      end

      next_page_number = api_response[:paging][:next]
    end

    items
  end

  private

  def make_api_call(url, params={})
    response = RestClient.get url, {:Authorization => 'Bearer ' + ACCESS_KEY, params: params}

    JSON.parse(response.body, symbolize_names: true)
  end
end
