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
site = Site.create!(name: 'Find', url: 'http://www.find.com')
Location.create!(book: book, site: site)
book2 = Book.create!(name: 'The Wind in the Willows2', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book3 = Book.create!(name: 'The Wind in the Willows3', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book4 = Book.create!(name: 'The Wind in the Willows4', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book5 = Book.create!(name: 'The Wind in the Willows5', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
book6 = Book.create!(name: 'The Wind in the Willows6', author: 'Kenneth Grahame', isbn: '0123456789', image:"https://upload.wikimedia.org/wikipedia/en/a/a4/Wind_in_the_willows.jpg")
Location.create!(book: book2, site: site)
Location.create!(book: book3, site: site)
Location.create!(book: book4, site: site)
Location.create!(book: book5, site: site)
Location.create!(book: book6, site: site)
