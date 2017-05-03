require 'rails_helper'

feature 'user adds books' do
  # As a user that would like to see the fair prices for books
  # I should be able to add multiple books at once
  # So that I can quickly make a decision about what price to sell/buy a book at
  #
  # [X] I should be able to add multiple books at a time either by their title, ISBN-10 or ISBN-13
  # [X] I should be redirected to the books new page and see error messages if I provide invalid information
  # [X] I should be taken to the first book I added's show page upon success
end
