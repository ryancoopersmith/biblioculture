class Site < ApplicationRecord
  validates :name, presence:true
  validates :url, presence:true
  validates :book_id, presence:true

  belongs_to :book
  has_many :books through: :locations
end
