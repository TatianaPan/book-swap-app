require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'GET/books' do
    user = users(:schmidt)
    sign_in user
    get user_books_url(user)
    assert_response :success
  end

  test 'GET/users/:user_id/books/new' do
    user = users(:schmidt)
    sign_in user
    get new_user_book_url(user)
    assert_response :success
  end

  test 'POST/books' do
    user = users(:schmidt)
    sign_in user
    book = books(:becoming)
    assert_difference 'Book.count', 1 do
      post user_books_url(user), params: { book: { title: book.title, author: book.author, user_id: book.user_id,
                                                   release_date: book.release_date, status: book.status,
                                                   isbn13: book.isbn13,
                                                   isbn10: book.isbn10, description: '' } }
    end
    assert_redirected_to user_books_url
  end

  test 'GET/users/:user_id/books/:id' do
    sign_in users(:schmidt)
    book = books(:becoming)
    get user_book_url(book.user, book)
    assert_response :success
  end

  test 'GET/users/:user_id/books/:id/edit' do
    user = users(:schmidt)
    sign_in user
    book = books(:becoming)
    get edit_user_book_url(user, book)
    assert_response :success
  end

  test 'PATCH/PUT/users/:user_id/books/:id' do
    user = users(:schmidt)
    sign_in user
    book = books(:becoming)
    patch user_book_url(user, book), params: { book: { status: 'reserved' } }
    assert_redirected_to user_book_url(book.user, book)
    assert_equal 'reserved', book.reload.status
  end

  test 'DELETE/books/:id' do
    user = users(:schmidt)
    sign_in user
    book = books(:becoming)
    assert_difference 'Book.count', -1 do
      delete user_book_url(user, book)
    end
  end
end
