class Room < ApplicationRecord
  validates :title, presence: true, length: { minimun: 1, maximum: 30 }

  belongs_to :user
  has_many :messages, dependent: :destroy
end
