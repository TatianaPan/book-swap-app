class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.timestamps
    end
  end
end
