class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :category
      t.string :address
      t.integer :zip_code
      t.string :price
      t.string :phone
      t.string :display_phone
      t.float :rating
      t.string :img_url
      t.float :longitude
      t.float :latitude
      t.string :hours
      t.string :special_features
      t.timestamps
    end
  end
end
