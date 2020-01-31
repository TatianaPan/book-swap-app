require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get homepage' do
    sign_in users(:schmidt)
    get root_url
    assert_response :success
  end
end
