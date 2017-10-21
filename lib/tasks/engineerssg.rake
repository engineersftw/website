namespace :engineerssg do
  desc "Gets list of videos from the playlist"
  task update_playlist: :environment do
    puts 'Starting to pull YouTube Playlist'

    youtube_service = YoutubeService.new
    Playlist.active.each do |playlist|
      puts 'Retrieving Playlist Info from YouTube... for ' + playlist.playlist_id

      playlist_info = youtube_service.fetch_playlist_details(playlist.playlist_id)
      playlist.name = playlist_info.snippet.title
      playlist.publish_date = playlist_info.snippet.published_at
      playlist.description = playlist_info.snippet.description if playlist.description.empty?
      playlist.image = playlist_info.snippet.thumbnails.high.url
      playlist.save

      items = youtube_service.retrieve_playlist(playlist.playlist_id)
      puts "#{items.count} items found..."

      items.each_with_index do |item, index|
        episode = Episode.find_or_initialize_by(video_id: item[:video_id])

        episode.title = item[:title] if episode.title.empty?
        episode.published_at = item[:published_at]
        episode.description = item[:description] if episode.description.empty?
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

  desc 'Parse content'
  task parse_content: :environment do
    puts 'Starting parsing of description'

    Episode.all.each do |episode|
      title = episode.title
      description = episode.description

      puts 'Title: ' + title
      # puts 'Description: ' + description

      puts 'Group name:'
      group_name = title.index('-') ? title.split('-').last.try(:strip) : nil
      puts group_name
      if group_name.present?
        organization = Organization.find_or_create_by(title: group_name)
        VideoOrganization.find_or_create_by(organization: organization, episode: episode)
      end

      puts 'Speaker:'
      speaker_matcher = /\ASpeaker:\s?(?<speaker>.*)\n/.match(description)
      puts speaker_name = speaker_matcher.try(:[], :speaker)
      if speaker_matcher.present?
        speaker_name = speaker_matcher.try(:[], :speaker).strip

        twitter_matcher = /\(@(?<twitter>.*)\)/.match(speaker_name)
        speaker_name.gsub!(/\(@(?<twitter>.*)\)/, '').strip! if twitter_matcher.present?

        byline_matcher = /,(?<byline>.*)/.match(speaker_name)
        speaker_name.gsub!(/,(?<byline>.*)/, '').strip! if byline_matcher.present?

        presenter = Presenter.find_or_initialize_by(name: speaker_name)
        presenter.twitter = twitter_matcher[:twitter] if twitter_matcher.present?
        presenter.byline = byline_matcher[:byline] if byline_matcher.present?
        presenter.save

        VideoPresenter.find_or_create_by(presenter: presenter, episode: episode)
      end

      puts 'Event Page: '
      event_matcher = /Event Page:\s?(?<event>https?:\/\/[\S]+)/.match(description)
      puts event_url = event_matcher.try(:[], :event)

      if event_url.present?
        VideoLink.find_or_create_by(episode: episode, url: event_url) do |l|
          l.title = 'Event Page'
          l.active = true
        end
      end

      puts '=============================='
    end
  end

  desc 'Twitter profile images'
  task fetch_twitter_avatar: :environment do

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.bearer_token        = ENV['TWITTER_BEARER_TOKEN']
    end

    presenters = Presenter.where("twitter <> ''").all

    presenters.map(&:twitter).each_slice(100) do |presenter_slice|
      client.users(*presenter_slice).each do |user|
        presenter = presenters.find{|u| u.twitter.downcase == user.screen_name.downcase}
        avatar_image = user.profile_image_uri_https('200x200').to_s.gsub(/\_normal$/, '')

        puts "#{presenter.try(:name)} - #{user.screen_name} - #{avatar_image}"
        presenter.update(avatar_url: avatar_image) if presenter
      end
    end
  end

  desc 'Update view count'
  task fetch_video_stats: :environment do
    puts 'Retrieving YouTube Videos...'

    youtube_service = YoutubeService.new
    Episode.where(video_site: Episode.video_sites[:youtube]).find_in_batches(batch_size: 50) do |batch|
      video_ids = batch.map(&:video_id)
      youtube_videos = youtube_service.fetch_video_stats(video_ids)

      batch_update = {}
      youtube_videos.each do |video_item|
        # puts "Updating view count for #{video_item.id} with #{video_item.statistics.viewCount}"

        episode = batch.select{|v| v.video_id == video_item.id }.first
        batch_update[episode.id] = { view_count: video_item.statistics.viewCount }
      end

      puts 'Batch update now...'
      puts batch_update
      Episode.update( batch_update.keys, batch_update.values )
    end

    puts '=================================================='
    puts 'Retrieving Vimeo Videos...'

    vimeo_batch_update = {}

    vimeo_episodes = Episode.where(video_site: Episode.video_sites[:vimeo]).all
    puts "Updating video stats for #{vimeo_episodes.count} videos."

    vimeo_service = VimeoService.new
    vimeo_videos = vimeo_service.get_uploaded_videos

    vimeo_videos.each do |video_item|
      episode = vimeo_episodes.select{ |v| v.video_id == video_item[:video_id] }.first

      next if episode.nil?

      vimeo_batch_update[episode.id] = {view_count: video_item[:view_count]}
    end

    puts 'Batch update now...'
    puts vimeo_batch_update
    Episode.update( vimeo_batch_update.keys, vimeo_batch_update.values )
  end
end
