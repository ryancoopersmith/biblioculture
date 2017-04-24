require 'open-uri'

class EbaySpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
  end

  def parse
    if @name
      return Nokogiri::HTML(open("http://search.half.ebay.com/#{@name}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
    elsif @isbn_10
      return Nokogiri::HTML(open("http://search.half.ebay.com/#{@isbn_10}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
    else
      return Nokogiri::HTML(open("http://search.half.ebay.com/#{@isbn_13}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
    end
  end

  def scrape
    books = response.xpath('//*[@class="imageborder"]/@href').extract()

    name = response.xpath('//*[@class="pdppagetitle"]/text()').extract_first()

    authors = response.xpath('//*[@class="pdplinks"]/*[@class="pdplinks"]/text()').extract()
    author = authors.join(', ')

    isbn_10 = isbn(reponse, 'ISBN-10:')
    isbn_13 = isbn(response, 'ISBN-13:')

    image = response.xpath('//tr/td/*[@class="imageborder"]/@src').extract_first()

    price = response.xpath('//*[@class="pdpbestpricestyle"]/text()').extract_first()

    if price
      price.gsub!('$', '')
    else
      price = 0
    end
  end

  def isbn(response, value)
    return response.xpath('//*[text()="' + value + '"]/following-sibling::span/a/text()').extract_first()
  end
end
