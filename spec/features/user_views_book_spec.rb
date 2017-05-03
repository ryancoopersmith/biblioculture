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

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'user views book' do
    book = Book.create(name: 'The Great Catsby', author: 'F. Scott Fitzgarfield', isbn_10: '1234567890')
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

  scenario 'user views previous book' do
    book = Book.create(name: 'The Great Catsby', author: 'F. Scott Fitzgarfield', isbn_10: '1234567890')
    site = Site.create(name: 'Amazon')
    Location.create(book: book, site: site)
    price = Price.create(price: '$4.50', book: book)
    SitePrice.create(site: site, price: price)

    book2 = Book.create(name: 'The Great Catsby2', author: 'F. Scott Fitzgarfield2', isbn_10: '1234567892')
    site2 = Site.create(name: 'Ebay')
    Location.create(book: book2, site: site2)
    price2 = Price.create(price: '$3.50', book: book2)
    SitePrice.create(site: site2, price: price2)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    visit book_path(book2)
    click_link "Previous Book"

    expect(page).to have_content("By: F. Scott Fitzgarfield")
    expect(page).to have_content("The Great Catsby")
    expect(page).to have_content("1234567890")
    expect(page).to have_content("Site: Amazon, Price: $4.50")
    expect(page).to have_content("Normal Distribution Graph: (Using 3 Standard Deviations)")
    expect(page).to have_content("Recommendation: Buy books at -1σ and sell books at 1σ")
  end

  scenario 'user views next book' do
    book = Book.create(name: 'The Great Catsby', author: 'F. Scott Fitzgarfield', isbn_10: '1234567890')
    site = Site.create(name: 'Amazon')
    Location.create(book: book, site: site)
    price = Price.create(price: '$4.50', book: book)
    SitePrice.create(site: site, price: price)

    book2 = Book.create(name: 'The Great Catsby2', author: 'F. Scott Fitzgarfield2', isbn_10: '1234567892')
    site2 = Site.create(name: 'Ebay')
    Location.create(book: book2, site: site2)
    price2 = Price.create(price: '$3.50', book: book2)
    SitePrice.create(site: site2, price: price2)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    visit book_path(book)
    click_link "Next Book"

    expect(page).to have_content("By: F. Scott Fitzgarfield2")
    expect(page).to have_content("The Great Catsby2")
    expect(page).to have_content("1234567892")
    expect(page).to have_content("Site: Ebay, Price: $3.50")
    expect(page).to have_content("Normal Distribution Graph: (Using 3 Standard Deviations)")
    expect(page).to have_content("Recommendation: Buy books at -1σ and sell books at 1σ")
  end
end
