class Book < ApplicationRecord
  validates :name, presence: true

  has_many :locations
  has_many :sites, through: :locations
  has_many :prices
end
