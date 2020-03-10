require 'test_helper'

class BookPolicyTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  test 'user can new, create, edit, update and destroy his own books only' do
    user = users(:schmidt)
    book = books(:becoming)

    sign_in user

    assert_permit(user, book, :new?)
    assert_permit(user, book, :create?)
    assert_permit(user, book, :edit?)
    assert_permit(user, book, :update?)
    assert_permit(user, book, :destroy?)
  end

  test 'user can NOT new, create, edit, update and destroy other user books' do
    user = users(:hoffman)
    book = books(:becoming)

    sign_in user

    refute_permit(user, book, :new?)
    refute_permit(user, book, :create?)
    refute_permit(user, book, :edit?)
    refute_permit(user, book, :update?)
    refute_permit(user, book, :destroy?)
  end
end
