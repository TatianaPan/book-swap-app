require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_omniauth]
  end

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
end
