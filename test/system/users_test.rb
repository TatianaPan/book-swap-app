require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'user can sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'm.schmidt@gmail.com'
    fill_in 'Password', with: '56kogakhdgTR'

    click_on 'Log in'
    assert_selector 'h1', text: 'Welcome to Book Swap App'
  end

  test 'user can sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'john.doe@gamil.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    assert_selector '.notice', text: 'Welcome! You have signed up successfully.'
  end

  test 'user can sign out' do
    sign_in users(:schmidt)
    visit root_path
    click_on 'Sign out'
    assert_selector 'h2', text: 'Log in'
  end

  test 'display all users' do
    sign_in users(:schmidt)
    visit root_path

    click_on 'All users'

    assert_selector 'h1', text: 'Users'

    within 'table.all-users' do
      assert_selector 'tbody tr:nth-child(1) td:nth-child(1)', text: 'Michael Schmidt'
    end
  end

  test 'user can edit user profile' do
    user = users(:schmidt)
    sign_in user

    visit root_path
    click_on 'My Profile'

    assert_selector 'h1', text: 'My profile'
    click_on 'Edit'

    assert_selector 'h1', text: 'Edit profile'
    click_on 'Cancel'
    assert_selector 'h1', text: 'My profile'

    click_on 'Edit'
    fill_in 'First name', with: 'Mischa'

    click_on 'Save'
    assert_selector '.notice', text: 'Your profile has been updated.'
  end

  test 'user can delete his profile if he has no associated records' do
    user = users(:hoffman)
    sign_in user

    visit edit_user_path(user)

    accept_confirm do
      click_link('Delete')
    end

    assert_selector '.alert', text: 'Your account has been deleted.'
  end

  test 'user cannot delete his account because of rectrictions' do
    user = users(:schmidt)
    sign_in user

    visit edit_user_path(user)

    accept_confirm do
      click_link('Delete')
    end

    assert_selector '.alert', text: 'You cannot delete your account.'
  end
end
