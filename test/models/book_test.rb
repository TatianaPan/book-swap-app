require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'isbn10 and isbn13 should be a string of numbers' do
    book = Book.new(title: 'Pippi Langstrumf', release_date: '1994',
                    status: 'available', isbn10: '1234arbnsP', isbn13: 'hgTb$12345123')

    book.validate
    assert_includes book.errors.to_a, 'Isbn10 is not a number'
    assert_includes book.errors.to_a, 'Isbn13 is not a number'
  end

  test 'remove trailing whitespaces in title, isbn10 and isbn13 fields' do
    book = Book.create(title: ' Pippi Langstrumf ', release_date: '1994',
                       status: 'available', isbn10: '1546890654 ', isbn13: ' 9078612345123')

    assert_equal 'Pippi Langstrumf', book.title
    assert_equal '1546890654', book.isbn10
    assert_equal '9078612345123', book.isbn13
  end

  test '#handle_status_and_borrower_correlation does not alter the book when status = available' do
    book = books(:becoming)

    assert_no_changes 'book.status' do
      assert_no_changes 'book.borrower_id' do
        book.update(isbn10: '1234567890')
      end
    end
  end

  # rubocop: disable Layout/LineLength
  test '#handle_status_and_borrower_correlation does not override the provided borrower if the borrower is not the owner of the book' do
    book = books(:becoming)
    user = users(:hoffman)

    assert_changes 'book.status', from: 'available', to: 'reserved' do
      assert_changes 'book.borrower_id', from: nil, to: user.id do
        book.update(status: 'reserved', borrower: user)
      end
    end
  end

  test '#handle_status_and_borrower_correlation raise validation error if status = available and borrower_id.present?' do
    book = books(:becoming)
    user = users(:hoffman)
    # The current borrower is already nil.
    assert_no_changes 'book.borrower_id' do
      book.update(status: 'available', borrower: user)
    end
  end

  # rubocop: enable Layout/LineLength

  test '#handle_status_and_borrower_correlation sets borrower to owner if owner reserves/borrows his book' do
    book = books(:becoming)
    user = users(:schmidt)

    assert_changes 'book.status', from: 'available', to: 'reserved' do
      assert_changes 'book.borrower_id', from: nil, to: user.id do
        book.update(status: 'reserved')
      end
    end
  end

  test '.search_by_author_title' do
    user = users(:schmidt)
    assert_equal 1, Book.search_by_author_title('obama becoming ').count
    assert_changes 'Book.search_by_author_title("линдгрен").count', from: 1, to: 2 do
      book = Book.new(title: 'Карлсон, который живет на крыше',
                      first_name: 'Астрид',
                      last_name: 'Линдгрен',
                      release_date: '1994',
                      status: 'available',
                      isbn10: '1546890654 ',
                      isbn13: ' 9078612345123',
                      user: user)
      book.save!
    end
  end
end
