require 'test_helper'

class OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_omniauth]
  end

  test 'POST/users/auth/google_oauth2/callback' do
    post user_google_oauth2_omniauth_callback_path
    assert :success
  end
end
