require 'rails_helper'

feature 'user visits privacy policy' do
  # As a user looking to find book prices
  # I want to view the privacy policy
  # So that I know if my information is private or not

  # [X] I should be able to find the privacy policy on the index page

  let!(:user) { FactoryGirl.create(:user) }

  scenario "user finds the privacy policy from the index page" do
    visit root_path
    click_link "Privacy Policy"

    expect(page).to have_content("Privacy Policy")
  end
end
