class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :books, dependent: :restrict_with_exception
  has_many :borrowed_books,
           class_name: 'Book',
           foreign_key: :borrower_id,
           inverse_of: :borrower,
           dependent: :restrict_with_exception

  validates :first_name, length: { maximum: 25 }, presence: true
  validates :last_name, length: { maximum: 25 }, presence: true

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
