require 'rails_helper'

feature 'user adds books' do
  # As a user that would like to see the fair prices for books
  # I should be able to add multiple books at once
  # So that I can quickly make a decision about what price to sell/buy a book at
  #
  # [X] I should be able to add multiple books at a time either by their title, ISBN-10 or ISBN-13
  # [X] I should be redirected to the books new page and see error messages if I provide invalid information
  # [X] I should be taken to the first book I added's show page upon success

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user successfully adds books' do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Add Books"

    fill_in "book-field-1", with: "The Great Gatsby"
    fill_in "book-field-2", with: "Peter Pan"
    click_button "Add"
    expect(page).to have_content("Fitzgerald")
    click_link "Next Book"

    expect(page).to have_content("Barrie")
  end

  scenario 'user submits empty form' do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "Add Books"

    fill_in "book-field-1", with: ""
    click_button "Add"

    expect(page).to have_content("You must supply either the title, ISBN-10 or ISBN-13")
  end
end
