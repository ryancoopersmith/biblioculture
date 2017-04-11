class Price < ApplicationRecord
  validates :price, presence:true
  validates :book_id, presence:true

  belongs_to :book
end
