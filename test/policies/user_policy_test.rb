require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  test 'user can edit, update and destroy his own profile only' do
    user = users(:schmidt)
    record = users(:schmidt)

    sign_in user

    assert_permit(user, record, :edit?)
    assert_permit(user, record, :update?)
    assert_permit(user, record, :destroy?)
  end

  test 'user can NOT edit, update and destroy other user profile' do
    user = users(:hoffman)
    record = users(:schmidt)

    sign_in user

    refute_permit(user, record, :edit?)
    refute_permit(user, record, :update?)
    refute_permit(user, record, :destroy?)
  end
end
