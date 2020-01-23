require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get homepage' do
    get root_url
    assert_response :redirect
    follow_redirect!
    sign_in users(:schmidt)
    assert_response :success
    get root_url
    assert_response :success
  end
end
