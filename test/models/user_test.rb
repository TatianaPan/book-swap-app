require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_omniauth]
  end

  test 'user gets created if user with the same email does not exist' do
    assert_difference 'User.count', 1 do
      data = OmniAuth.config.mock_auth[:google_omniauth].info
      user = User.create_if_not_exist(data)
      assert_equal 'john@example.com', user.email
    end
  end

  test 'user is not created if user with the same email exist' do
    user = users(:schmidt)
    data = { email: 'm.schmidt@gmail.com', first_name: '', last_name: '' }
    assert_no_difference 'User.count' do
      matching_user = User.create_if_not_exist(data)
      assert_equal user.email, matching_user.email
    end
  end

  test 'should not create user without first name or last name' do
    user = User.new(email: 'marion.myer@example.com', password: '123kfhg', first_name: '', last_name: ' ')
    user.validate
    assert_includes user.errors.to_a, "First name can't be blank"
    assert_includes user.errors.to_a, "Last name can't be blank"
  end
end
