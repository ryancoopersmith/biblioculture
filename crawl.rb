require 'open-uri'

url = "https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=the+great+gatsby"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
