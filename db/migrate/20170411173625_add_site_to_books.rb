class AddSiteToBooks < ActiveRecord::Migration[5.0]
  def up
    add_reference :books, :site, index: true
  end

  def down
    remove_reference :books, :site
  end
end
