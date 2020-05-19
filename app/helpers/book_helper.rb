module BookHelper
  def reservation_button_label(book)
    book.status == 'reserved' ? 'Unreserve' : 'Reserve'
  end

  def next_reservation_status(book)
    book.status == 'available' ? 'reserved' : 'available'
  end

  def status_icon(book)
    if book.available?
      image_pack_tag('media/images/icons8-green-circle-50.png', style: 'width: 20px;')
    elsif book.reserved?
      image_pack_tag('media/images/icons8-orange-circle-50.png', style: 'width: 20px;')
    elsif book.borrowed?
      image_pack_tag('media/images/icons8-red-circle-50.png', style: 'width: 20px;')
    end
  end
end
