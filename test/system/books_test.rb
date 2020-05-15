require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'display books of current user' do
    sign_in users(:schmidt)
    visit root_path

    click_on 'My library'

    assert_selector 'h1', text: 'My library'

    within 'table.my-books' do
      assert_selector 'tbody tr'
    end
  end

  test 'user can see list of books of other user' do
    sign_in users(:hoffman)
    user = users(:schmidt)

    visit users_path

    within 'table tbody tr:nth-child(1) td:nth-child(4)' do
      click_on 'Library'
    end

    assert_selector 'h1', text: "#{user.decorate.display_full_name}'s library"
  end

  test 'user can add new book' do
    user = users(:schmidt)
    sign_in user
    visit new_user_book_path(user)

    fill_in 'Title', with: 'Harry Potter and the Chamber of Secrets'
    fill_in 'Author', with: 'J.K.Rowling'
    fill_in 'ISBN 13', with: '9781408810545'
    select('2010', from: 'Published Date')

    click_on 'Save'

    assert_selector 'notice', text: 'Book has been added successfully.'
  end

  test 'user can edit book info' do
    user = users(:schmidt)
    sign_in user

    visit user_books_path(user)
    click_on 'Becoming'

    assert_selector 'h1', text: 'Becoming'
    click_on 'Edit'
    click_on 'Cancel'

    click_on 'Edit'
    select('reserved', from: 'Status')

    click_on 'Save'
    assert_selector 'notice', text: 'Book has been updated successfully.'
  end

  test 'user can delete a book' do
    user = users(:schmidt)
    sign_in user
    book = books(:becoming)

    visit user_book_path(user, book)

    accept_confirm do
      click_link('Delete')
    end

    assert_selector 'notice', text: 'Book has been deleted.'
  end

  test "user do not see EDIT and DELETE button on other user's show book page" do
    user = users(:hoffman)
    book = books(:becoming)

    sign_in user

    visit user_book_path(book.user, book)

    assert_no_selector 'a', text: 'Edit'
    assert_no_selector 'a', text: 'Delete'
  end

  test 'user can reserve an available book that they do not own' do
    user = users(:hoffman)
    book = books(:becoming)
    sign_in user

    visit user_book_path(book.user, book)

    assert_changes 'book.reload.status', from: 'available', to: 'reserved' do
      click_on 'Reserve'
    end

    assert_selector 'notice', text: 'Book has been updated successfully.'
    assert_equal 'Unreserve', find('.reservation-btn').value
  end

  test 'user can unreserve book reserved by him' do
    user = users(:schmidt)
    book = books(:lord_of_rings_reserved)
    sign_in user

    visit user_book_path(book.user, book)
    assert_changes 'book.reload.status', from: 'reserved', to: 'available' do
      click_on 'Unreserve'
    end

    assert_selector 'notice', text: 'Book has been updated successfully.'
    assert_equal 'Reserve', find('.reservation-btn').value
  end

  test 'user cannot see the reserve/unreserve button if the book is reserved by another user' do
    user = users(:schuhmacher)
    book = books(:lord_of_rings_reserved)
    sign_in user

    visit user_book_path(book.user, book)

    assert_selector 'p', text: 'reserved'
    assert_no_selector 'input', class: 'reservation-btn'
  end

  test 'user cannot reserve/unreserve his own book on book profile' do
    user = users(:schmidt)
    book = books(:becoming)
    sign_in user

    visit user_book_path(book.user, book)
    assert_no_selector 'input', class: 'reservation-btn'
  end
end
