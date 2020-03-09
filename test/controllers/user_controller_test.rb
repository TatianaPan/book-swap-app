require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'GET/users' do
    sign_in users(:schmidt)
    get users_path
    assert_response :success
  end

  test 'GET/users/:id' do
    user = users(:schmidt)
    sign_in user
    get user_url(user)
    assert_response :success
  end

  test 'GET/users/:id/edit' do
    user = users(:schmidt)
    sign_in user
    get edit_user_url(user)
    assert_response :success
  end

  test 'PATCH/PUT/users/:id' do
    user = users(:schmidt)
    sign_in user
    assert_changes 'user.locations', to: 'Adliswill' do
      patch user_url(user), params: { user: { locations: 'Adliswill' } }
      user.reload.locations
    end
    assert_redirected_to user_url(user)
    assert_equal 'Your profile has been updated.', flash[:notice]
  end

  test 'DELETE/users/:id' do
    user = users(:hoffman)
    sign_in user
    assert_difference 'User.count', -1 do
      delete user_url(user)
    end
  end

  test 'DELETE/users/:id with restriction error' do
    user = users(:schmidt)
    sign_in user
    assert_no_difference 'User.count' do
      delete user_url(user)
    end
    assert_redirected_to user_url(user)
  end
end
