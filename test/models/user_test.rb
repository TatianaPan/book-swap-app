require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user gets created if user with the same email does not exist' do
    assert_difference 'User.count', 1 do
      user = User.create_if_not_exist('john@example.com')
      assert_equal 'john@example.com', user.email
    end
  end

  test 'user is not created if user with the same email exist' do
    user = users(:schmidt)
    assert_no_difference 'User.count' do
      matching_user = User.create_if_not_exist('m.schmidt@gmail.com')
      assert_equal user, matching_user
    end
  end
end
