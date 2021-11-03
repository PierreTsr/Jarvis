class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :category
      t.string :location
      t.string :price
      t.string :phone
      t.string :display_phone
      t.float :rating
      t.string :img_url

      t.timestamps
    end
  end
end
