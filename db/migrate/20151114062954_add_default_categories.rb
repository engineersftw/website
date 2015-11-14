class AddDefaultCategories < ActiveRecord::Migration
  def self.up
    %w(Conference Meetup Tutorial Training).each do |title|
      PlaylistCategory.find_or_create_by(title: title)
    end

    Playlist.all.each do |playlist|
      if playlist.playlist_id == 'PLECEw2eFfW7hYMucZmsrryV_9nIc485P1'
        category = PlaylistCategory.find_by(title: 'Meetup')
      else
        category = PlaylistCategory.find_by(title: 'Conference')
      end
      playlist.update(playlist_category: category)
    end
  end

  def self.down
  end
end
