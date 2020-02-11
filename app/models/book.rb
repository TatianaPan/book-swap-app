class Book < ApplicationRecord
  validates :isbn10, length: { is: 10 },
                     format: { with: /\A\d+\z/, message: 'Only numbers are allowed' },
                     allow_blank: true
  validates :isbn13, length: { is: 13 },
                     format: { with: /\A\d+\z/, message: 'Only numbers are allowed' },
                     allow_blank: true
  validates :title, :author, :status, presence: true
end
