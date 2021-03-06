require 'rails_helper'

feature 'user signs up' do
  # As a new user that wants to check the fair book prices
  # I should be able to sign up using my personal information
  # So that I can be granted access to see the book pricing information
  #
  # [X] I must provide a unique username
  # [X] I must provide a valid email
  # [X] I must provide a password
  # [X] I must provide a password confirmation that matches my password
  # [X] I should see an error message if I enter invalid information
  # [X] I should remain on the sign up page if I enter invalid information
  # [X] I should see a success message if I successfully sign up
  # [X] I should be taken to the root path when I sign up
  # [X] I should be sent a success email if I successfully sign up

  before { ActionMailer::Base.deliveries = [] }

  scenario 'user visits sign up page' do
    visit new_user_registration_path
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Username')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password Confirmation')
  end

  scenario 'user successfully signs up' do
    visit new_user_registration_path
    fill_in 'Username', with: 'johnnyboy1'
    fill_in 'Email', with: 'johnnyboy1@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to_not have_content('Sign Up')
    expect(page).to_not have_content('Sign In')
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  scenario 'user provides different password confirmation' do
    visit new_user_registration_path
    fill_in 'Username', with: 'leonardo5'
    fill_in 'Email', with: 'leonardo5@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'notmypassword'
    click_button 'Sign Up'

    expect(page).to have_content("Password confirmation doesn't match")
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content("Welcome! You have signed up successfully.")
  end

  scenario 'user provides invalid email' do
    visit new_user_registration_path
    fill_in 'Username', with: 'fredrick13'
    fill_in 'Email', with: 'wrongemail@.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to_not have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content('Email is invalid')
    expect(page).to have_content('Sign Up')
  end

  scenario 'user provides missing information' do
    visit new_user_registration_path
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to_not have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content('Sign Up')
  end
end
