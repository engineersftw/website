class Presenter < ActiveRecord::Base
  has_many :video_presenters, dependent: :destroy
  has_many :episodes, through: :video_presenters

  def avatar(size=256)
    if twitter.present?
      return "http://avatars.io/twitter/#{twitter}?size=large"
    elsif email.present?
      hash = Digest::MD5.hexdigest email.downcase.strip
      return "http://gravatar.com/avatar/#{hash}?s=#{size}&d=retro"
    elsif avatar_url.present?
      return avatar_url
    end
  end
end
