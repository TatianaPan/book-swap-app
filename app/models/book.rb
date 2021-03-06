class Book < ApplicationRecord
  STATUSES_REQUIRING_A_BORROWER = %w[reserved borrowed].freeze

  belongs_to :user
  belongs_to :borrower, class_name: 'User', inverse_of: :books_on_loan, optional: true
  enum status: { available: 'available', reserved: 'reserved', borrowed: 'borrowed' }

  before_validation :strip_input_fields
  before_save :handle_status_and_borrower_correlation

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

  def handle_status_and_borrower_correlation
    # If the borrower is already set, do not do anything.
    return if STATUSES_REQUIRING_A_BORROWER.include?(status) && borrower.present?

    # If status changed to reserved/borrowed, but no borrower present, it means borrower is the owner
    self.borrower = !STATUSES_REQUIRING_A_BORROWER.include?(status) ? nil : user
  end
end
