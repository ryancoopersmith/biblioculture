require 'rails_helper'

feature 'user views book' do
  # As a user that would like to see the fair prices for a book
  # I should be able to see specific information about that book such as the range of prices it's selling for
  # So that I know what price I should buy/sell that book for
  #
  # [X] I should see the book's title, image, ISBN-10, and author(s)
  # [X] I should see a standard deviation bell curve of the fair prices for the book
  # [X] I should see the sites and their associated prices for the book
  # [X] I should see the recommended prices to sell/buy the book at
  # [X] I should be able to go to the next and previous books that I've added

  let!(:book) { FactoryGirl.create(:book) }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user views book' do
    site = Site.create(name: 'Amazon')
    Location.create(book: book, site: site)
    price = Price.create(price: '$4.50', book: book)
    SitePrice.create(site: site, price: price)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    visit book_path(book)

    expect(page).to have_content("By: F. Scott Fitzgarfield")
    expect(page).to have_content("The Great Catsby")
    expect(page).to have_content("1234567890")
    expect(page).to have_content("Site: Amazon, Price: $4.50")
    expect(page).to have_content("Normal Distribution Graph: (Using 3 Standard Deviations)")
    expect(page).to have_content("Recommendation: Buy books at -1σ and sell books at 1σ")
  end
end
