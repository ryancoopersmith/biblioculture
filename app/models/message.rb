class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later(self) }

  validates :body, presence: true, length: { minimun: 1, maximum: 500 }

  belongs_to :user
  belongs_to :chat_room

  def timestamp
    day = created_at.strftime('%B %d, %Y')
    hour = created_at.strftime('%H').to_i
    minute = created_at.strftime('%M').to_i
    morning = true
    if hour >= 12
      morning = false
      unless hour == 12
        hour -= 12
      end
    end
    if morning
      time = "#{hour}:#{minute} AM, #{day}"
    else
      time = "#{hour}:#{minute} PM, #{day}"
    end
    time
  end
end
