class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.string :isbn10, limit: 10
      t.string :isbn13, limit: 13
      t.date :year
      t.string :status, default: 'available'
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
