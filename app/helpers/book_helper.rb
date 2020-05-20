module BookHelper
  AVAILABLE_ICON_PATH = 'media/images/icons8-green-circle-50.png'.freeze
  RESERVED_ICON_PATH = 'media/images/icons8-orange-circle-50.png'.freeze
  BORROWED_ICON_PATH = 'media/images/icons8-red-circle-50.png'.freeze

  def reservation_button_label(book)
    book.status == 'reserved' ? 'Unreserve' : 'Reserve'
  end

  def next_reservation_status(book)
    book.status == 'available' ? 'reserved' : 'available'
  end

  def status_icon(book)
    icon_path = if book.available?
                  AVAILABLE_ICON_PATH
                elsif book.reserved?
                  RESERVED_ICON_PATH
                elsif book.borrowed?
                  BORROWED_ICON_PATH
                end
    return if icon_path.nil?

    image_pack_tag(icon_path, style: 'width: 15px;')
  end
end
