class RemoveAuthorNameFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_columns :books, :first_name, :last_name
  end
end
