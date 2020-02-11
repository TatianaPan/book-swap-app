require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'isbn10 and isbn13 should be a string of numbers' do
    book = Book.new(title: 'Pippi Langstrumf', author: 'Atsrid Lindgren', year: '1994',
                    status: 'available', isbn10: '1234arbnsP', isbn13: 'hgTb$12345123')

    book.validate
    assert_includes book.errors.to_a, 'Isbn10 Only numbers are allowed'
    assert_includes book.errors.to_a, 'Isbn13 Only numbers are allowed'
  end
end
