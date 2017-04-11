class AddBookToPrices < ActiveRecord::Migration[5.0]
  def up
    add_reference :prices, :book, index: true
  end

  def down
    remove_reference :prices, :book
  end
end
