require 'google/api_client'

class YoutubeService
  DEVELOPER_KEY = "AIzaSyAnql4dYjLTLSmWi6JYoES0ftTm9CBf_i0"
  YOUTUBE_API_SERVICE_NAME = "youtube"
  YOUTUBE_API_VERSION = "v3"
  MEETUPS_PLAYLIST = 'PLECEw2eFfW7hYMucZmsrryV_9nIc485P1'

  def retrieve_playlist
    items = []

    next_page_token = ''
    until next_page_token.nil?
      opts = {
        part: 'snippet',
        maxResults: 50,
        playlistId: MEETUPS_PLAYLIST,
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

  private

  def api_client
    @google_api_client ||= Google::APIClient.new(key: DEVELOPER_KEY, authorization: nil, application_name: 'Engineers.SG', application_version: '1.0.0')
  end

  def youtube
    @youtube_api ||= api_client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
  end
end
