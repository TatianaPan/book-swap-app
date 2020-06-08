require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
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

  test 'user searches for a book' do
    sign_in users(:schmidt)
    visit root_path

    # search in Russian by name without capital letter and with trailing whitespaces
    assert_changes "find_all('tbody tr').count", to: 1 do
      fill_in 'Author or title', with: ' линдгрен '
      click_on 'Search'
    end

    # search in Russian by author's first name and one word from book title
    fill_in 'Author or title', with: 'пеппи аСтрИд '
    click_on 'Search'

    within 'table.table.all-books tbody ' do
      assert_selector 'tr:nth-child(1) td:nth-child(1)', text: 'Астрид Линдгрен'
      assert_selector 'tr:nth-child(1) td:nth-child(2)', text: 'Пеппи Длинныйчулок'
    end

    # searcg in English by author last name and 2 words from title case insensitive
    fill_in 'Author or title', with: ' rowling harry potter '
    click_on 'Search'

    within 'table.table.all-books tbody ' do
      assert_selector 'tr:nth-child(1) td:nth-child(1)', text: 'J.K. Rowling'
      assert_selector 'tr:nth-child(1) td:nth-child(2)', text: "Harry Potter and the Philosopher's Stone"
    end

    # search for misspelled book
    fill_in 'Author or title', with: 'Tolkin '
    click_on 'Search'
    assert_selector 'notice', text: 'There is no such book in our catalogue.'
  end

  test 'user searches for a book that is not in catalogue' do
    sign_in users(:schmidt)
    visit root_path

    # search for a book with no mathces in catalogue
    fill_in 'Author or title', with: 'дЖулия Дональдсон '
    click_on 'Search'
    assert_selector 'notice', text: 'There is no such book in our catalogue.'

    # search for an empty string
    fill_in 'Author or title', with: ' '
    click_on 'Search'
    assert_selector 'notice', text: 'There is no such book in our catalogue.'
  end
end
