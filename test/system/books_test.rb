require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'display books' do
    sign_in users(:schmidt)
    visit root_path

    click_on 'My library'

    assert_selector 'h1', text: 'My library'

    within 'table.my-books' do
      assert_selector 'tbody tr'
    end
  end

  test 'user can add new book' do
    sign_in users(:schmidt)
    visit new_book_path

    fill_in 'Title', with: "Harry Potter and the Philosopher's Stone"
    fill_in 'Author', with: 'J.K.Rowling'
    fill_in 'ISBN 13', with: '9781408810545'
    select('2010', from: 'Published Date')

    click_on 'Save'

    assert_selector '.notice', text: 'Book has been added successfully.'
  end

  test 'user can edit book info' do
    sign_in users(:schmidt)

    visit books_path
    click_on 'Becoming'

    assert_selector 'h1', text: 'Becoming'
    click_on 'Edit'
    click_on 'Cancel'

    click_on 'Edit'
    select('reserved', from: 'Status')

    click_on 'Save'
    assert_selector '.notice', text: 'Book has been updated successfully.'
  end

  test 'user can delete a book' do
    sign_in users(:schmidt)
    book = books(:becoming)

    visit book_path(book)

    accept_confirm do
      click_link('Delete')
    end

    assert_selector '.notice', text: 'Book has been deleted.'
  end
end
