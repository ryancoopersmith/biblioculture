class Site < ApplicationRecord
  validates :name, presence:true
  validates :url, presence:true

  belongs_to :book
  has_many :books, through: :locations
end
