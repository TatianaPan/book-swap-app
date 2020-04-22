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

  test 'POST/users/:user_id/books' do
    user = users(:schmidt)
    sign_in user

    book_params = { book: { title: 'Three Daughters of Eve', author: 'Elif Shafak',
                            release_date: '2020-12-05', status: 'available',
                            isbn13: '',
                            isbn10: '', description: '', borrower_id: nil } }
    assert_difference 'Book.count', 1 do
      post user_books_url(user), params: book_params
    end
    assert_redirected_to user_books_url
  end

  test 'POST/users/:user_id/books should not create a book for another user' do
    user = users(:hoffman)
    another_user = users(:schmidt)

    sign_in user

    book_params = { book: { title: 'Life of Pi', author: 'Yann Martel',
                            release_date: Date.new(2016, 1, 1), status: 'available',
                            description: '' } }

    assert_no_difference 'Book.count' do
      post user_books_url(another_user), params: book_params
    end

    assert_redirected_to root_url
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

  test 'PATCH/PUT/users/:user_id/books/:id should not edit book' do
    user = users(:hoffman)
    book = books(:becoming)

    sign_in user

    assert_no_changes 'book.status' do
      patch user_book_url(book.user, book), params: { book: { status: 'reserved' } }
    end
    assert_redirected_to root_path
  end

  test 'DELETE/books/:id' do
    user = users(:schmidt)
    sign_in user
    book = books(:becoming)
    assert_difference 'Book.count', -1 do
      delete user_book_url(user, book)
    end
  end

  test 'DELETE/books/:id redirects to root if book not authorized' do
    user = users(:hoffman)
    book = books(:becoming)
    sign_in user

    assert_no_difference 'Book.count' do
      delete user_book_url(book.user, book)
    end
    assert_redirected_to root_path
  end

  test 'PATCH/PUT/users/:user_id/books/:id/reserve' do
    user = users(:hoffman)
    book = books(:becoming)
    sign_in user

    put reserve_user_book_path(book.user, book)
    assert_equal user.id, book.reload.borrower_id
    assert_equal 'reserved', book.reload.status
  end

  test 'PATCH/PUT/users/:user_id/books/:id/unreserve' do
    user = users(:hoffman)
    book = books(:harry_potter)
    sign_in user

    book.update(status: 'reserved', borrower_id: user.id)
    put unreserve_user_book_path(book.user, book)

    assert_equal 'available', book.reload.status
    assert_nil book.reload.borrower_id
  end
end
