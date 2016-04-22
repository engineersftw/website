module ApplicationHelper
  def twitter_share_text(episode)
    string = episode.title
    if episode.presenters.count > 0
      episode.presenters.each do |presenter|
        string += " @#{presenter.twitter}" if presenter.twitter.present?
      end
    end

    string
  end
end
