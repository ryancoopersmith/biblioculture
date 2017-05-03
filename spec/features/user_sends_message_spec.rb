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

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user visits chat room' do
    room = Room.create(title: 'Dogs', user: user)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Chat Rooms"

    click_link "Enter Dogs"

    expect(page).to have_content("Dogs")
    expect(page).to have_content("See all Rooms")
  end
  #
  # scenario 'user successfully sends message' do
  #   room = Room.create(title: 'Dogs', user: user)
  #
  #   visit new_user_session_path
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "Sign In"
  #   click_link "Chat Rooms"
  #
  #   click_link "Enter Dogs"
  #   fill_in "Body", with: "The Great Catsby?"
  #
  #   expect(page).to have_content("The Great Catsby?")
  #   expect(page).to have_content("testuser")
  # end
  #
  # scenario 'user sends empty message' do
  #   room = Room.create(title: 'Dogs', user: user)
  #
  #   visit new_user_session_path
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "Sign In"
  #   click_link "Chat Rooms"
  #
  #   click_link "Enter Dogs"
  #   fill_in "Body", with: ""
  #
  #   expect(page).to_not have_content("testuser")
  # end
end
