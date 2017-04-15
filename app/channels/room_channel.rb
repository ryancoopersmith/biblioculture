class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel" # needs an id for multiple rooms
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['message'])
  end
end
