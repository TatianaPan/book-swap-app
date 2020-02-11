class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :books, dependent: :destroy

  def self.create_if_not_exist(email)
    user = User.find_by(email: email)
    return user if user.present?

    User.create(email: email, password: Devise.friendly_token[0, 20])
  end
end
