require 'test_helper'

# Make sure that https://nvd.nist.gov/vuln/detail/CVE-2015-9284 is mitigated
class OmniauthCsrfTest < ActionDispatch::IntegrationTest
  setup do
    ActionController::Base.allow_forgery_protection = true
  end

  test 'should not accept GET requests to OmniAuth endpoint' do
    get '/users/auth/google_oauth2'
    assert_response :missing
  end

  test 'should not accept POST requests with invalid CSRF tokens to OmniAuth endpoint' do
    assert_raises ActionController::InvalidAuthenticityToken do
      post '/users/auth/google_oauth2'
    end
  end

  teardown do
    ActionController::Base.allow_forgery_protection = false
  end
end
