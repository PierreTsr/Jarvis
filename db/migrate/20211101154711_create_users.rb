class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :from_country
      t.string :address
      t.integer :work
      t.integer :budget
      t.integer :zip_code
      t.float :latitude
      t.float :longitude
      
      t.timestamps
    end
  end
end
