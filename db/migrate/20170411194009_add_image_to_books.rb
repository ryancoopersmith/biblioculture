class AddImageToBooks < ActiveRecord::Migration[5.0]
  def up
    add_column :books, :image, :string
  end

  def down
    remove_column :books, :image
  end
end
