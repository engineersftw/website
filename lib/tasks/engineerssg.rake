namespace :engineerssg do
  desc "Gets list of videos from the playlist"
  task update_playlist: :environment do
    puts 'Starting to pull YouTube Playlist'

    items = YoutubeService.new.retrieve_playlist

    puts "#{items.count} items found..."

    items.each_with_index do |item, index|
      episode = Episode.find_or_initialize_by(video_id: item[:video_id])

      episode.title = item[:title]
      episode.published_at = item[:published_at]
      episode.description = item[:description]
      episode.image1 = item[:image1]
      episode.image2 = item[:image2]
      episode.image3 = item[:image3]
      episode.sort_order = index
      episode.save
    end
  end

end
