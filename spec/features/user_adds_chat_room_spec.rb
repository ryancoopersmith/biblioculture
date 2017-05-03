require 'rails_helper'

feature 'user adds chat room' do
  # As a user that would like to chat with other users
  # I should be able to add my own chat room
  # So that I can chat with cetrain users about a specific topic
  #
  # [X] The chat room title must be one character or longer
  # [X] I should see a success message and be taken to that chat room upon success
  # [X] I should see an error message if I provide an invalid room title

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user successfully adds chat room' do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Chat Rooms"
    click_link "New Room"

    fill_in "Title", with: "Discussion"
    click_button "Add"

    expect(page).to have_content("Discussion")
    expect(page).to have_content("See all Rooms")
  end

  scenario 'user submits missing room title' do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Chat Rooms"
    click_link "New Room"

    fill_in "Title", with: ""
    click_button "Add"

    expect(page).to_not have_content("See all Rooms")
    expect(page).to have_content("Title can't be blank .")
  end

  scenario 'user submits invalid room title' do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Chat Rooms"
    click_link "New Room"

    fill_in "Title", with: "fdsafdsafdsafdsafdsafdsafdsafdsafdsafdsa"
    click_button "Add"

    expect(page).to_not have_content("See all Rooms")
    expect(page).to_not have_content("fdsafdsafdsafdsafdsafdsafdsafdsafdsafdsa")
    expect(page).to have_content("Title is too long (maximum is 30 characters) .")
  end
end
