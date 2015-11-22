class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  def password_required?
    provider.present? ? false : super
  end

  def email_required?
    provider.present? && provider == 'twitter' ? false : super
  end

  def self.from_omniauth(auth)
    user = where(provider:auth.provider, uid:auth.uid).first || where(twitter:auth.info.nickname).first || new
    user.update_attributes provider: auth.provider,
                           uid:      auth.uid,
                           twitter:  auth.info.nickname
    user
  end
end
