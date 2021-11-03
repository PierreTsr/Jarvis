class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :from_country
      t.string :to_city
      t.integer :work
      t.integer :budget

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
