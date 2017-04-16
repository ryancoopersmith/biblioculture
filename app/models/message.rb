class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later(self) }

  validates :body, presence: true, length: { maximum: 500 }

  belongs_to :user
  belongs_to :chat_room

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
