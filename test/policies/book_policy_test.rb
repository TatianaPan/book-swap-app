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

  test 'user can NOT reserve and unreserve his own book' do
    user = users(:schmidt)
    book = books(:becoming)

    sign_in user

    refute_permit(user, book, :reserve?)
    refute_permit(user, book, :unreserve?)
  end

  test 'user can reserve a book of another user' do
    user = users(:hoffman)
    book = books(:becoming)

    sign_in user

    assert_permit(user, book, :reserve?)
  end

  test 'user can unreserve a book reserved by his own' do
    user = users(:hoffman)
    book = books(:becoming)

    sign_in user

    book.update(status: 'reserved', borrower_id: user.id)
    assert_permit(user, book, :unreserve?)
  end
end
