class UserDecorator < SimpleDelegator
  def display_full_name
    "#{first_name} #{last_name}"
  end
end
