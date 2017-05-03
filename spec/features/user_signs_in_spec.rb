require 'rails_helper'

feature 'user signs in' do
  # As an returning user that wants to check the fair book prices
  # I should be able to sign in using my account information
  # So that I can be granted access to see the book pricing information
  #
  # [X] If I visit the root path without being authenticated first I should be redirected to the sign in page
  # [X] I must provide a valid email
  # [X] I must provide a valid password
  # [X] I should see an error message if I enter an invalid email or password
  # [X] I should remain on the sign in page if I enter invalid information
  # [X] I should see a success message if I successfully sign in
  # [X] I should be taken to the root path when I sign in

  scenario 'user visits the root path without being authenticated first' do
    visit root_path
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'user successfully signs in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("You've successfully signed in!")
    expect(page).to_not have_content('Sign In')
    expect(page).to_not have_content('Sign Up')
  end

  scenario 'user provides incorrect password' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'notmypassword'
    click_button 'Sign In'

    expect(page).to have_content("Invalid Email or password.")
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content("You've successfully signed In!")
  end

  scenario 'user provides incorrect email' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrongemail@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to_not have_content("You've successfully signed in!")
    expect(page).to have_content('Invalid Email or password.')
    expect(page).to have_content('Sign In')
  end

  scenario 'user provides missing information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    click_button 'Sign In'

    expect(page).to_not have_content("You've successfully signed In!")
    expect(page).to have_content("Invalid Email or password.")
    expect(page).to have_content('Sign In')
  end
end
