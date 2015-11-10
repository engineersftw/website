namespace :engineerssg do
  desc "Gets list of videos from the playlist"
  task update_playlist: :environment do
    puts 'Starting to pull YouTube Playlist'

    youtube_service = YoutubeService.new
    Playlist.active.each do |playlist|
      puts 'Retrieving Playlist Info from YouTube... for' + playlist.playlist_id

      playlist_info = youtube_service.fetch_playlist_details(playlist.playlist_id)
      playlist.name = playlist_info.snippet.title
      playlist.publish_date = playlist_info.snippet.published_at
      playlist.description = playlist_info.snippet.description
      # if playlist_info.snippet.thumbnails.maxres.present?
      #   playlist.image = playlist_info.snippet.thumbnails.maxres.url
      # else
        playlist.image = playlist_info.snippet.thumbnails.high.url
      # end
      playlist.save

      items = youtube_service.retrieve_playlist(playlist.playlist_id)
      puts "#{items.count} items found..."

      items.each_with_index do |item, index|
        episode = Episode.find_or_initialize_by(video_id: item[:video_id])

        episode.title = item[:title]
        episode.published_at = item[:published_at]
        episode.description = item[:description]
        episode.image1 = item[:image1]
        episode.image2 = item[:image2]
        episode.image3 = item[:image3]
        episode.save

        playlist_item = PlaylistItem.find_or_initialize_by(playlist: playlist, episode: episode)
        playlist_item.sort_order = index
        playlist_item.save
      end
    end
  end

end
