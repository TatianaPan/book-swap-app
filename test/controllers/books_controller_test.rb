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
    book = books(:becoming)
    sign_in user

    book_params = { book: { title: book.title, author: book.author,
                            release_date: book.release_date, status: book.status,
                            isbn13: book.isbn13,
                            isbn10: book.isbn10, description: '', borrower_id: book.borrower_id } }
    assert_difference 'Book.count', 1 do
      byebug
      post user_books_url(user), params: book_params
      byebug
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
end
