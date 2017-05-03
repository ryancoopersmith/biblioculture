require 'rails_helper'

feature 'user views chat rooms' do
  # As a user that would like to chat with other users
  # I should be able to see a list of available chat rooms
  # So that I can decide which chat room to enter
  #
  # [X] I should be able to see a list of all available chat rooms

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user views chat rooms' do
    Room.create(title: 'Philosophy', user: user)
    Room.create(title: 'Science', user: user)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Chat Rooms"

    expect(page).to have_content("Philosophy")
    expect(page).to have_content("Science")
    expect(page).to_not have_content("History")
  end
end
