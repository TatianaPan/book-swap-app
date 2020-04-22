class AddReservedByToBooks < ActiveRecord::Migration[6.0]
  def change
    change_table :books do |t|
      t.references :borrower, foreign_key: { to_table: :users }, null: true
    end
  end
end
