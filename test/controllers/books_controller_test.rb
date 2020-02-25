require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'GET/books' do
    sign_in users(:schmidt)
    get books_url
    assert_response :success
  end

  test 'GET/books/new' do
    sign_in users(:schmidt)
    get new_book_url
    assert_response :success
  end

  test 'POST/books' do
    sign_in users(:schmidt)
    book = books(:becoming)
    assert_difference 'Book.count', 1 do
      post books_url, params: { book: { title: book.title, author: book.author, user_id: book.user_id,
                                        release_date: book.release_date, status: book.status, isbn13: book.isbn13,
                                        isbn10: book.isbn10, description: '' } }
    end
    assert_redirected_to books_url
  end

  test 'GET/books/:id' do
    sign_in users(:schmidt)
    book = books(:becoming)
    get book_url(book)
    assert_response :success
  end

  test 'GET/books/:id/edit' do
    sign_in users(:schmidt)
    book = books(:becoming)
    get edit_book_url(book)
    assert_response :success
  end

  test 'PATCH/PUT/books/:id' do
    sign_in users(:schmidt)
    book = books(:becoming)
    patch book_url(book), params: { book: { status: 'reserved' } }
    assert_redirected_to book_url(book)
    assert_equal 'reserved', book.reload.status
  end

  test 'DELETE/books/:id' do
    sign_in users(:schmidt)
    book = books(:becoming)
    assert_difference 'Book.count', -1 do
      delete book_url(book)
    end
  end
end
