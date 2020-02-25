class Book < ApplicationRecord
  belongs_to :user
  validates :isbn10, length: { is: 10 },
                     numericality: { only_integer: true, greater_than: 0 },
                     allow_blank: true
  validates :isbn13, length: { is: 13 },
                     numericality: { only_integer: true, greater_than: 0 },
                     allow_blank: true
  validates :title, :author, :status, presence: true
end
