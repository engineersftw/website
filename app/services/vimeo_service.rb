class VimeoService
  ACCESS_KEY = ENV['VIMEO_BEARER_TOKEN']

  def get_video(video_id)
    video_url = "https://api.vimeo.com/videos/#{video_id}"
    response = RestClient.get video_url, {:Authorization => 'Bearer ' + ACCESS_KEY}
    response_json = JSON.parse(response.body, symbolize_names: true)

    Episode.new(
      video_site: 'vimeo',
      video_id: video_id,
      title: response_json[:name],
      published_at: response_json[:created_time],
      description: response_json[:description],
      image1: response_json[:pictures][:sizes][1][:link],
      image2: response_json[:pictures][:sizes][3][:link],
      image3: response_json[:pictures][:sizes][5][:link]
    )
  end
end
