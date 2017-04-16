class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A((\w+)|(\.))+\@[a-z]+\.[a-z]{3}\z/ }
  validates :role, inclusion: { in: ['admin', 'member'] }

  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
end
