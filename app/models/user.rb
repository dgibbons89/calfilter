class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:uid)).first.tap do |user|
      user.name = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end