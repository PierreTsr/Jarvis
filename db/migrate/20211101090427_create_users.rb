class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, limit: 32
      t.string :from_country
      t.string :to_city
      t.integer :work
      t.integer :budget

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
