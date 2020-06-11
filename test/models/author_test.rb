require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test 'validates first_name and last_name presence' do
    author = Author.new(first_name: ' ', last_name: '')
    author.validate

    assert_includes author.errors.to_a, "First name can't be blank"
    assert_includes author.errors.to_a, "Last name can't be blank"
  end
end
