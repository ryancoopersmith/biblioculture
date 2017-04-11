class AddBookToSites < ActiveRecord::Migration[5.0]
  def up
    add_reference :sites, :book, index: true
  end

  def down
    remove_reference :sites, :book
  end
end
