require 'google/apis/youtube_v3'

class YoutubeService
  def initialize(
      access_token:,
      refresh_token: nil,
      client_id: ENV['GOOGLE_API_CLIENT_ID'],
      client_secret: ENV['GOOGLE_API_CLIENT_SECRET']
  )
    @access_token = access_token
    @refresh_token = refresh_token
    @client_id = client_id
    @client_secret = client_secret
  end

  def retrieve_playlist(playlist_id)
    items = []

    next_page_token = ''
    until next_page_token.nil?
      api_response = api_client.list_playlist_items('snippet', max_results: 50, page_token: next_page_token, playlist_id: playlist_id)
      api_response.items.each do |playlist_item|
        if playlist_item.snippet.thumbnails.present?
          item = {
              video_id: playlist_item.snippet.resource_id.video_id,
              title: playlist_item.snippet.title,
              published_at: playlist_item.snippet.published_at,
              description: playlist_item.snippet.description,
              image1: playlist_item.snippet.thumbnails.default.url,
              image2: playlist_item.snippet.thumbnails.medium.url,
              image3: playlist_item.snippet.thumbnails.high.url
          }
          items << item
        end
      end

      next_page_token = api_response.next_page_token
    end

    items
  end

  def fetch_playlist_details(playlist_id)
    api_response = api_client.list_playlists('snippet', id: playlist_id)

    api_response.items.first unless api_response.items.empty?
  end

  def get_video(video_id)
    api_response = api_client.list_videos('snippet,status', id: video_id)
    video_item = api_response.items.first

    Episode.new(
      video_site: 'youtube',
      video_id: video_id,
      title: video_item.snippet.title,
      published_at: video_item.snippet.published_at,
      description: video_item.snippet.description,
      image1: video_item.snippet.thumbnails.default.url,
      image2: video_item.snippet.thumbnails.medium.url,
      image3: video_item.snippet.thumbnails.high.url
    )
  end

  def fetch_video_stats(video_ids=[])
    video_ids_string = video_ids.join(',')
    api_response = api_client.list_videos('statistics', id: video_ids_string, max_results: 50)

    api_response.items
  end

  def upload_video(options={})
    snippet = Google::Apis::YoutubeV3::VideoSnippet.new({title: options[:title],
                                                         description: options[:description],
                                                         category_id: '28'})
    status = Google::Apis::YoutubeV3::VideoStatus.new({privacy_status: 'public',
                                                       license: 'creativeCommon',
                                                       embeddable: true})
    video_object = Google::Apis::YoutubeV3::Video.new({ snippet: snippet, status: status })
    upload_source = options[:file]

    api_client.insert_video('snippet,status', video_object, upload_source: upload_source, content_type: 'video/*')
  end

  def add_to_playlist(options={})
    resource = Google::Apis::YoutubeV3::ResourceId.new({
                                                           kind: 'youtube#video',
                                                           video_id: options[:video_id]
                                                       })

    snippet = Google::Apis::YoutubeV3::PlaylistItemSnippet.new({
                                                                   playlist_id: options[:playlist_id],
                                                                   resource_id: resource
                                                               })

    playlist_item_object = Google::Apis::YoutubeV3::PlaylistItem.new(snippet: snippet)

    playlist_item_insert_response = api_client.insert_playlist_item('snippet', playlist_item_object)

    playlist_item_insert_response
  end

  def update_video(options={})
    snippet = Google::Apis::YoutubeV3::VideoSnippet.new({title: options[:title],
                                                         description: options[:description],
                                                         category_id: '28'})
    status = Google::Apis::YoutubeV3::VideoStatus.new({privacy_status: 'public',
                                                       license: 'creativeCommon',
                                                       embeddable: true})
    video_object = Google::Apis::YoutubeV3::Video.new({ id: options[:id], snippet: snippet, status: status })

    api_client.update_video('id,snippet,status', video_object)
  end

  private

  def api_client
    @service ||= Google::Apis::YoutubeV3::YouTubeService.new.tap do |service|
      service.authorization = authorization
    end
  end

  def authorization
    @authorization ||= GoogleAuthService.new.client(access_token: @access_token, refresh_token: @refresh_token).tap do |client|
      client.refresh!
    end
  end
end