# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Site.destroy_all

User.create!(username: 'ryan', email: 'ryancoopersmith1@gmail.com', password: 'password', password_confirmation: 'password', role: 'admin')
User.create!(username: 'evi', email: 'evianneelise@gmail.com', password: 'password', password_confirmation: 'password', role: 'admin')

Site.create!(name: 'Amazon', url: 'http://www.amazon.com')
Site.create!(name: 'Half.com - eBay', url: 'http://www.half.ebay.com')
Site.create!(name: 'Alibris', url: 'http://www.alibris.com')
Site.create!(name: 'Powell\'s Books', url: 'http://www.powells.com')
