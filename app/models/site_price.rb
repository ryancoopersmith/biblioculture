class SitePrice < ApplicationRecord
  validates :price_id, presence: true
  validates :site_id, presence: true

  belongs_to :price
  belongs_to :site
end
