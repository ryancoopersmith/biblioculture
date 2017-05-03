require 'rails_helper'

feature 'user sends message' do
  # As a user that would like to talk in the chat rooms
  # I should be able to send a message
  # So that other users can see what I have to say
  #
  # [X] The message body must be one character or longer
  # [X] The message must not be longer that 500 characters
  # [X] I should see that message immediately upon sending it
  # [X] I should see an error message if I provide an invalid message body
  # [X] If I tag people in my message they should get an email with that message in it
end
