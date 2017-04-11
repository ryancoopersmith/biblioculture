class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :book_id
      t.integer :site_id
    end
  end
end
