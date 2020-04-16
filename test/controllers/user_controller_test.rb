require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'POST/users' do
    user_params = { user: { email: 'john.doe@gmail.com',
                            password: '123ght356',
                            first_name: 'John',
                            last_name: 'Doe' } }
    assert_difference 'User.count', 1 do
      post user_registration_url, params: user_params
    end
    assert_redirected_to root_url
  end

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

  test 'PATCH/PUT/users/:id should not update without authorisation' do
    user = users(:hoffman)
    another_user = users(:schmidt)
    sign_in user

    assert_no_changes 'another_user.locations' do
      patch user_url(another_user), params: { user: { locations: 'Adliswill' } }
      another_user.reload.locations
    end
    assert_redirected_to root_url
  end

  test 'DELETE/users/:id' do
    user = users(:hoffman)
    sign_in user
    assert_difference 'User.count', -1 do
      delete user_url(user)
    end
  end

  test 'DELETE/users/:id should not delete without authorization' do
    user = users(:hoffman)
    another_user = users(:schmidt)
    sign_in user

    assert_no_difference 'User.count' do
      delete user_url(another_user)
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
