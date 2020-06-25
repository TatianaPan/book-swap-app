require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test 'validates first_name and last_name presence' do
    author = Author.new(first_name: ' ', last_name: '')
    author.validate

    assert_includes author.errors.to_a, "First name can't be blank"
    assert_includes author.errors.to_a, "Last name can't be blank"
  end

  test 'remove trailing whitespaces in first name and  last name fields' do
    author = Author.create(first_name: ' Astrid ', last_name: ' Lindgren')

    assert_equal 'Astrid', author.first_name
    assert_equal 'Lindgren', author.last_name
  end
end
