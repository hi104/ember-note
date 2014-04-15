class User < ActiveRecord::Base

  has_many :notes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable,
  :trackable, :omniauthable, :omniauth_providers => [:github, :twitter]

  class << self
    def find_for_github_oauth(auth, signed_in_resource = nil)
      oauth_first_or_initialize(auth, signed_in_resource)
    end

    def find_for_twitter_oauth(auth, signed_in_resource = nil)
      oauth_first_or_initialize(auth, signed_in_resource)
    end

    def oauth_first_or_initialize(auth, signed_in_resource = nil)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email || ""
        # user.password = Devise.friendly_token[0,20]   # what use ?
        user.name = auth.info.name   # assuming the user model has a name
        # user.image = auth.info.image # assuming the user model has an image
        user.save!
      end
    end

  end
end
