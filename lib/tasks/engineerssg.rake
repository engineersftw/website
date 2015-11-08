namespace :engineerssg do
  desc "Gets list of videos from the playlist"
  task update_playlist: :environment do
    puts 'Starting to pull YouTube Playlist'

    Playlist.active.each do |playlist|
      items = YoutubeService.new.retrieve_playlist(playlist.playlist_id)

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
