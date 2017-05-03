require 'rails_helper'

feature 'user visits account page' do
  # As an authenticated user that wants to check the fair book prices
  # I should be able to see my account information
  # So that I change my account information
  #
  # [X] I should be able to see and edit my username
  # [X] I should be able to see and edit my email
  # [X] I should be able to see and edit my password
  # [X] I should be able to delete my account

  let!(:user) { FactoryGirl.create(:user) }

  scenario "user clicks on 'My Account'" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "My Account"

    expect(page).to have_content("My Account")
    expect(page).to have_content("Cancel my account")
  end

  scenario "user successfully edits account information" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "My Account"
    fill_in "Username", with: "newusername"
    fill_in "Password", with: 'newpassword'
    fill_in "Password Confirmation", with: "newpassword"
    fill_in "Current Password", with: user.password
    click_button "Update"

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario "user edits account with invalid information" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "My Account"
    fill_in "Email", with: "newemail@com"
    click_button "Update"

    expect(page).to_not have_content('Your account has been updated successfully.')
    expect(page).to have_content('Email is invalid')
  end

  scenario "user deletes account" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    click_link "My Account"
    click_button "Cancel my account"

    expect(page).to_not have_content('Bye! We hope to see you again soon')
    expect(page).to_not have_content('Sign Out')
  end
end
