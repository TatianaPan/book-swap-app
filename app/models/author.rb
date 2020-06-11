class Author < ApplicationRecord
  include Strippable

  STRIPPABLE_ATTRIBUTES = %w[first_name last_name].freeze

  has_many :books, dependent: :destroy
  before_validation :strip_input_fields
  validates :first_name, :last_name, presence: true
end
