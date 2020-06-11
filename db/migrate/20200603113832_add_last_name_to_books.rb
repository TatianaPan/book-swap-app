class AddLastNameToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :last_name, :string, null: false, default: ''
    add_index :books, :title
    rename_column :books, :author, :first_name
  end
end
