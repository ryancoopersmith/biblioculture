# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Book.destroy_all
Site.destroy_all
Location.destroy_all

User.create!(username: 'ryan', email: 'ryancoopersmith1@gmail.com', password: 'password', password_confirmation: 'password', role: 'admin')
User.create!(username: 'evi', email: 'evianneelise@gmail.com', password: 'password', password_confirmation: 'password', role: 'admin')

book = Book.create!(name: 'The Wind in the Willows', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book2 = Book.create!(name: 'The Wind in the Willows2', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book3 = Book.create!(name: 'The Wind in the Willows3', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book4 = Book.create!(name: 'The Wind in the Willows4', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book5 = Book.create!(name: 'The Wind in the Willows5', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book6 = Book.create!(name: 'The Wind in the Willows6', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book7 = Book.create!(name: 'The Wind in the Willows7', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book8 = Book.create!(name: 'The Wind in the Willows8', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book9 = Book.create!(name: 'The Wind in the Willows9', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book10 = Book.create!(name: 'The Wind in the Willows10', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book11 = Book.create!(name: 'The Wind in the Willows11', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")

site = Site.create!(name: 'Find', url: 'http://www.find.com')
site2 = Site.create!(name: 'Find2', url: 'http://www.find.com')
site3 = Site.create!(name: 'Find3', url: 'http://www.find.com')
site4 = Site.create!(name: 'Find4', url: 'http://www.find.com')
site5 = Site.create!(name: 'Find5', url: 'http://www.find.com')
site6 = Site.create!(name: 'Find6', url: 'http://www.find.com')

Location.create!(book: book, site: site)
Location.create!(book: book2, site: site)
Location.create!(book: book3, site: site)
Location.create!(book: book4, site: site)
Location.create!(book: book5, site: site)
Location.create!(book: book6, site: site)
Location.create!(book: book7, site: site)
Location.create!(book: book8, site: site)
Location.create!(book: book9, site: site)
Location.create!(book: book10, site: site)
Location.create!(book: book11, site: site)

price = Price.create!(price: 10.21, book: book)
price2 = Price.create!(price: 10.22, book: book2)
price3 = Price.create!(price: 10.23, book: book3)
price4 = Price.create!(price: 10.24, book: book4)
price5 = Price.create!(price: 10.25, book: book5)
price6 = Price.create!(price: 10.26, book: book6)
price7 = Price.create!(price: 10.27, book: book7)
price8 = Price.create!(price: 10.28, book: book8)
price9 = Price.create!(price: 10.29, book: book9)
price10 = Price.create!(price: 1.21, book: book10)
price11 = Price.create!(price: 1.22, book: book11)
price12 = Price.create!(price: 10.22, book: book)
price13 = Price.create!(price: 9.22, book: book)
price14 = Price.create!(price: 8.22, book: book)

SitePrice.create!(site: site, price: price)
SitePrice.create!(site: site2, price: price2)
SitePrice.create!(site: site3, price: price3)
SitePrice.create!(site: site4, price: price4)
SitePrice.create!(site: site5, price: price5)
SitePrice.create!(site: site6, price: price6)
SitePrice.create!(site: site2, price: price7)
SitePrice.create!(site: site2, price: price8)
SitePrice.create!(site: site3, price: price9)
SitePrice.create!(site: site3, price: price10)
SitePrice.create!(site: site3, price: price11)
SitePrice.create!(site: site2, price: price12)
SitePrice.create!(site: site3, price: price13)
SitePrice.create!(site: site4, price: price14)
