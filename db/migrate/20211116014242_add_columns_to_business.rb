class AddColumnsToBusiness < ActiveRecord::Migration[6.1]
  def change
    add_column :businesses, :description, :text
    add_column :businesses, :working_hours, :text
  end
end
