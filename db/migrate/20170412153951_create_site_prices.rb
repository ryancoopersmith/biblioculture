class CreateSitePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :site_prices do |t|
      t.integer :site_id
      t.integer :price_id
    end
  end
end
