class AddLastNameToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :last_name, :string, null: false
    add_index :books, :last_name
    add_index :books, :title
    rename_index :books, "index_books_on_author", "index_books_on_first_name"
    rename_column :books, :author, :first_name
  end
end
