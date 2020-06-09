require 'test_helper'

class ReservationMailerTest < ActionMailer::TestCase

  setup do
    @book = books(:lord_of_rings_reserved)
    @owner = @book.user
    @borrower = @book.borrower
    ReservationMailer.new.reservation(@book).deliver
    @mail = ActionMailer::Base.deliveries.last
  end

  test 'general email settings are as expected' do
    # receiver is the book owner
    assert_includes @mail.to, @owner.email

    # sender is BookSwapApp email
    assert_includes @mail.from, 'bookswapapp.help@gmail.com'

    # subject is correct
    assert_includes @mail.subject, 'Your book has been reserved by Michael Schmidt'
  end

  test 'HTML part includes reservation information' do
    html_body = @mail.html_part.body

    # Greeting contains book's owner name
    assert_includes html_body, "Hi #{@owner.first_name}"

    # Book title
    assert_includes html_body, @book.title

    # Borrower info
    assert_includes html_body, @borrower.first_name
    assert_includes html_body, @borrower.last_name
    assert_includes html_body, @borrower.email
  end

  test 'TEXT part includes reservation information' do
    text_body = @mail.text_part.body

    # Greeting contains book's owner name
    assert_includes text_body, "Hi #{@owner.first_name}"

    # Book title
    assert_includes text_body, @book.title

    # Borrower info
    assert_includes text_body, @borrower.first_name
    assert_includes text_body, @borrower.last_name
    assert_includes text_body, @borrower.email
  end
end
