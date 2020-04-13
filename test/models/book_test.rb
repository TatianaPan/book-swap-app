require 'test_helper'

class BookTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  test 'isbn10 and isbn13 should be a string of numbers' do
    user = users(:schmidt)
    sign_in user

    book = Book.new(title: 'Pippi Langstrumf', author: 'Atsrid Lindgren', release_date: '1994',
                    status: 'available', isbn10: '1234arbnsP', isbn13: 'hgTb$12345123')

    book.validate
    assert_includes book.errors.to_a, 'Isbn10 is not a number'
    assert_includes book.errors.to_a, 'Isbn13 is not a number'
  end

  test 'remove trailing whitespaces in isbn10 and isbn13 fields' do
    user = users(:schmidt)
    sign_in user

    book = Book.create(title: 'Pippi Langstrumf', author: 'Atsrid Lindgren', release_date: '1994',
                       status: 'available', isbn10: '1546890654 ', isbn13: ' 9078612345123')

    assert_equal '1546890654', book.isbn10
    assert_equal '9078612345123', book.isbn13
  end
end
