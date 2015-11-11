class Presenter < ActiveRecord::Base
  has_many :video_presenters
  has_many :episodes, through: :video_presenters

  def avatar(size=73)
    if twitter.present?
      return "http://avatar.io/twitter/#{twitter}?size=large"
    elsif email.present?
      hash = Digest::MD5.hexdigest email.downcase.strip
      return "http://gravatar.com/avatar/#{hash}?s=#{size}&d=retro"
    end
  end
end
