class Location < ApplicationRecord
  validates :book_id, presence: true
  validates :site_id, presence: true

  belongs_to :book
  belongs_to :site
end
