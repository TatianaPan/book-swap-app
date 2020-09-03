require 'test_helper'

class StrippableTest < ActiveSupport::TestCase
  test 'should strip trailing whitespaces on input fields' do
    class ExampleClass
      include Strippable
      attr_accessor :username, :email, :phone
      STRIPPABLE_ATTRIBUTES = %w[username email phone].freeze

      def initizlize(username, email, phone)
        @username = username
        @email = email
        @phone = phone
      end
    end

    example = ExampleClass.new
    example.username = ' Donuld Duck'
    example.email = 'donald@yahoo.com '
    example.phone = '   '
    example.strip_input_fields

    assert_equal 'Donuld Duck', example.username
    assert_equal 'donald@yahoo.com', example.email
    assert_equal '', example.phone
  end
end
