class Price < ApplicationRecord
  validates :price, presence: true
  validates :book_id, presence: true

  belongs_to :book
  has_many :site_prices
  has_many :sites, through: :prices
end
