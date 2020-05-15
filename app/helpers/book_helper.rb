module BookHelper
  def reservation_button_label(book)
    book.status == 'reserved' ? "Unreserve" : "Reserve"
  end

  def next_reservation_status(book)
    book.status == :available ? 'reserved' : 'available'
  end
end
