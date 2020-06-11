class AddReferenceOnBookToAuthor < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :author, foreign_key: true, null: false, default: 1
  end
end
