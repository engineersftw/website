require 'google/api_client'

class YoutubeService
  YOUTUBE_API_SERVICE_NAME = "youtube"
  YOUTUBE_API_VERSION = "v3"

  def retrieve_playlist(playlist_id)
    items = []

    next_page_token = ''
    until next_page_token.nil?
      opts = {
        part: 'snippet',
        maxResults: 50,
        playlistId: playlist_id,
        pageToken: next_page_token
      }
      api_response = api_client.execute!(api_method: youtube.playlist_items.list, parameters: opts)
      api_response.data.items.each do |playlist_item|
        item = {
          video_id: playlist_item.snippet.resourceId.videoId,
          title: playlist_item.snippet.title,
          published_at: playlist_item.snippet.publishedAt,
          description: playlist_item.snippet.description,
          image1: playlist_item.snippet.thumbnails.default.url,
          image2: playlist_item.snippet.thumbnails.medium.url,
          image3: playlist_item.snippet.thumbnails.high.url
        }
        items << item
      end

      next_page_token = api_response.next_page_token
    end

    items
  end

  def fetch_playlist_details(playlist_id)
    opts = {
      part: 'snippet',
      id: playlist_id
    }
    api_response = api_client.execute!(api_method: youtube.playlists.list, parameters: opts)

    api_response.data.items.first unless api_response.data.items.empty?
  end

  def get_video(video_id)
    opts = {
      part: 'snippet',
      id: video_id
    }
    api_response = api_client.execute!(api_method: youtube.videos.list, parameters: opts)
    video_item = api_response.data.items.first

    Episode.new(
      video_site: 'youtube',
      video_id: video_id,
      title: video_item.snippet.title,
      published_at: video_item.snippet.publishedAt,
      description: video_item.snippet.description,
      image1: video_item.snippet.thumbnails.default.url,
      image2: video_item.snippet.thumbnails.medium.url,
      image3: video_item.snippet.thumbnails.high.url
    )
  end

  private

  def api_client
    @google_api_client ||= Google::APIClient.new(key: ENV['GOOGLE_DEV_KEY'], authorization: nil, application_name: 'Engineers.SG', application_version: '1.0.0')
  end

  def youtube
    @youtube_api ||= api_client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
  end
end
