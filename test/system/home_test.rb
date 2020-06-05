require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'should render list of all books sorted by author' do
    sign_in users(:schmidt)
    visit root_path

    assert_selector 'table.table.all-books'

    within 'table.table.all-books tbody ' do
      assert_selector 'tr:nth-child(1) td:nth-child(1)', text: 'Michelle Obama'
      assert_selector 'tr:nth-child(2) td:nth-child(1)', text: 'J.K. Rowling'
    end
  end

  test 'user searches a book by author in Russian' do
    sign_in users(:schmidt)
    visit root_path

    assert_changes "find_all('tbody tr').count", to: 1 do
      fill_in 'Author', with: 'линдгрен '
      click_on 'Search'
    end
  end
end
