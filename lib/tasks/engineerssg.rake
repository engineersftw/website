namespace :engineerssg do
  desc "TODO"
  task update_playlist: :environment do
    puts 'Starting to pull YouTube Playlist'

    items = YoutubeService.new.retrieve_playlist

    puts "#{items.count} items found..."

    items.each do |item|
      Episode.find_or_create_by(video_id: item[:video_id]) do |video|
        video.title = item[:title]
        video.published_at = item[:published_at]
        video.description = item[:description]
        video.image1 = item[:image1]
        video.image2 = item[:image2]
        video.image3 = item[:image3]
      end
    end
  end

end
