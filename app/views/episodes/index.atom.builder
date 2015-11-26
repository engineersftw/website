atom_feed do |feed|
  feed.title "Engineers.SG"
  feed.updated @episodes.maximum(:updated_at)

  @episodes.each do |episode|
    episode_content = '<iframe width="560" height="315" src="https://www.youtube.com/embed/' + episode.video_id + '" frameborder="0" allowfullscreen></iframe>' + auto_link(simple_format(episode.description))

    feed.entry episode, published: episode.published_at do |entry|
      entry.title episode.title
      entry.content(episode_content, type: 'html')
      entry.author do |author|
        author.name episode.presenters.try(:first).try(:name) || 'Engineers.SG'
      end
    end
  end
end
