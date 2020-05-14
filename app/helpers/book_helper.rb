module BookHelper
  def reservation_button_label(book)
    book.status == 'reserved' ? "Unreserve" : "Reserve"
  end
end
