class Book < ApplicationRecord
  validates :name, presence: true
  validates :author, presence: true
  validates :isbn_10, length: { is: 10 }
  validates :isbn_13, length: { is: 13 }, allow_nil: true

  has_many :locations
  has_many :sites, through: :locations
  has_many :prices
end
