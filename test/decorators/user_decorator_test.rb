require 'test_helper'

class UserDecoratorTest < ActiveSupport::TestCase
  test 'should display full name' do
    assert_equal 'Michael Schmidt', users(:schmidt).decorate.display_full_name
  end
end
