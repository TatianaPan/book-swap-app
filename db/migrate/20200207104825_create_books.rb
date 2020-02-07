class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.integer :isbn10
      t.integer :isbn13
      t.date :year
      t.string :status, default: 'available'
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
