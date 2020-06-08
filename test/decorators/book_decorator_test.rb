require 'test_helper'

class BookDecoratorTest < ActiveSupport::TestCase
  test 'should display author full name' do
    assert_equal 'Michelle Obama', books(:becoming).decorate.display_author_name
  end
end
