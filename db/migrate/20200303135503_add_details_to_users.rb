class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, limit: 25
      t.string :last_name, limit: 25
      t.text :locations
    end
  end
end
