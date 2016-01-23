class Presenter < ActiveRecord::Base
  has_many :video_presenters, dependent: :destroy
  has_many :episodes, through: :video_presenters

  def avatar(size=200)
    if avatar_url.present?
      return avatar_url
    elsif email.present?
      hash = Digest::MD5.hexdigest email.downcase.strip
      return "https://gravatar.com/avatar/#{hash}?s=#{size}&d=retro"
    elsif twitter.present?
      return "https://avatars.io/twitter/#{twitter}?size=large"
    end
  end
end
