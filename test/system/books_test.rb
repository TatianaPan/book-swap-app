require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

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
end
