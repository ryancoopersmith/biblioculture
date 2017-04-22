require 'open-uri'
require 'nokogiri'

url = "https://www.reddit.com/"
doc = Nokogiri::HTML(open(url))

entries = doc.css('.entry') # I can use xpath like normal here

class Entry
	def initialize(title, link)
		@title = title
		@link = link
	end
	attr_reader :title
	attr_reader :link
end
