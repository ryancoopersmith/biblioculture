class Site < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true

  has_many :locations
  has_many :books, through: :locations
  has_many :site_prices
  has_many :prices, through: :site_prices
end
