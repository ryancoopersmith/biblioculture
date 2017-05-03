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
  scenario 'user views book' do
    expect(page).to have_content("By: Francis Scott Fitzgerald")
    expect(page).to have_content("The Great Gatsby")
    expect(page).to have_content("068416325X")
    expect(page).to have_content("Site: Thrift Books, Price: $4.78")
    expect(page).to have_content("Site: Discover Books, Price: $3.58")
  end
end
