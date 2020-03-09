class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :books, dependent: :restrict_with_exception

  validates :first_name, length: { maximum: 25 }
  validates :last_name, length: { maximum: 25 }

  def self.create_if_not_exist(data)
    user = User.find_by(email: data[:email])
    return user if user.present?

    User.create(email: data[:email],
                password: Devise.friendly_token[0, 20],
                first_name: data[:first_name],
                last_name: data[:last_name])
  end

  def decorate
    @decorate ||= UserDecorator.new(self)
  end
end
