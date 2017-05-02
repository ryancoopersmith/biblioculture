class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_#{params['room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], room_id: data['room_id'])
    people = []
    message_letters = data['message'].split('')
    message_letters.length.times do |index|
      if message_letters[index] == '@' && message_letters[index + 1] != ' '
        letters = []
        counter = index + 1
        letter = message_letters[counter]
        while letter != ' ' && letter != '.' && letter != '!' && letter != '?' && counter < message_letters.length
          letters.push(letter)
          counter += 1
          letter = message_letters[counter]
        end
        people.push(letters.join(''))
      end
    end
    people.each do |person|
      User.all.each do |user|
        if user.username == person
          UserMailer.new_message(user, current_user, data['message']).deliver
        end
      end
    end
  end
end
