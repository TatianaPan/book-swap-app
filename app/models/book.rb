class Book < ApplicationRecord
  belongs_to :user
  belongs_to :borrower, class_name: 'User', inverse_of: :borrowed_books, optional: true
  before_validation :strip_input_fields

  validates :isbn10, length: { is: 10 },
                     numericality: { only_integer: true, greater_than: 0 },
                     allow_blank: true
  validates :isbn13, length: { is: 13 },
                     numericality: { only_integer: true, greater_than: 0 },
                     allow_blank: true
  validates :title, :author, :status, presence: true

  private

  def strip_input_fields
    self.isbn10 = isbn10.strip unless isbn10.nil?
    self.isbn13 = isbn13.strip unless isbn13.nil?
  end
end
