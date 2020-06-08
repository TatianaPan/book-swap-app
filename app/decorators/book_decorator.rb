class BookDecorator < SimpleDelegator
  def display_author_name
    "#{first_name} #{last_name}"
  end
end
