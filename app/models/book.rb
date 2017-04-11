class Book < ApplicationRecord
  validates :name, presence:true
  validates :author, presence:true
  validates :site_id, presence:true

  belongs_to :site
  has_many :sites, through: :locations
  has_many :prices
end
