class User < ApplicationRecord
  after_create :send_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A((\w+)|(\.))+\@[a-z]+\.[a-z]{3}\z/ }
  validates :role, inclusion: { in: ['admin', 'member'] }

  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  mount_uploader :profile_photo, ProfilePhotoUploader

  def send_email
    UserMailer.new_user(self).deliver
  end
end
