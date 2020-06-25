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

    book_params = { book: { title: 'Three Daughters of Eve',
                            release_date: '2020-12-05', status: 'available', isbn13: '',
                            isbn10: '', description: '', borrower_id: nil,
                            author_attributes: { first_name: 'Elif', last_name: 'Shafak' } } }
    assert_difference 'Book.count', 1 do
      post user_books_url(user), params: book_params
    end
    assert_redirected_to user_books_url
  end

  test 'POST/users/:user_id/books should not create a book for another user' do
    user = users(:hoffman)
    another_user = users(:schmidt)

    sign_in user

    book_params = { book: { title: 'Life of Pi', first_name: 'Yann', last_name: 'Martel',
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
    patch user_book_url(user, book), params: { book: { status: 'reserved', borrower_id: user.id } }
    assert_redirected_to user_book_url(book.user, book)
    assert_equal 'reserved', book.reload.status
    assert_equal user.id, book.borrower_id
  end

  test 'PATCH/PUT/users/:user_id/books/:id should not edit other users book except of status' do
    user = users(:hoffman)
    book = books(:becoming)
    previous_attributes = book.attributes.except(:status)

    sign_in user

    patch user_book_url(book.user, book), params: { book: { title: 'Normal People',
                                                            author_attributes:
                                                            { first_name: 'Sally',
                                                              last_name: 'Rooney' },
                                                            isbn10: '1524903152',
                                                            isbn13: '9781524763190',
                                                            release_date: '2017-02-01' } }

    assert_equal previous_attributes, book.reload.attributes.except(:status)
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

  test 'POST/users/:user_id/books creates author record' do
    user = users(:schmidt)
    sign_in user

    book_params = { book: { title: 'Three Daughters of Eve',
                            release_date: '2020-12-05', status: 'available', isbn13: '',
                            isbn10: '', description: '', borrower_id: nil,
                            author_attributes: { first_name: 'Elif', last_name: 'Shafak' } } }
    assert_difference 'Author.count', 1 do
      post user_books_url(user), params: book_params
    end
    assert_redirected_to user_books_url
  end

  test 'PATCH/PUT/users/:user_id/books/:id should update associated author record' do
    user = users(:schmidt)
    sign_in user
    book = books(:harry_potter)
    book_params = { book: { author_attributes: { first_name: 'Joanne' } } }

    patch user_book_url(user, book), params: book_params
    assert_redirected_to user_book_url(book.user, book)
    assert_equal 'Joanne', book.reload.author.first_name
    assert_equal book.author.id, book.reload.author.id
  end
end
