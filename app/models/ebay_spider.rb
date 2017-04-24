require 'open-uri'

class EbaySpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
    @doc = ''
  end

  def parse
    if @name
      @doc = Nokogiri::HTML(open("http://search.half.ebay.com/#{@name}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
    elsif @isbn_10
      @doc = Nokogiri::HTML(open("http://search.half.ebay.com/#{@isbn_10}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
    else
      @doc = Nokogiri::HTML(open("http://search.half.ebay.com/#{@isbn_13}_W0QQ_trksidZp3030Q2em1446Q2el2686"))
    end
  end

  def scrape_name
    # may possibly need this
    # books = @doc.xpath('//*[@class="imageborder"]/@href')

    @doc.xpath('//*[@class="pdppagetitle"]/text()')
  end

  def scrape_author
    authors = @doc.xpath('//*[@class="pdplinks"]/*[@class="pdplinks"]/text()')
    authors.join(', ')
  end

  def scrape_isbn_10
    isbn('ISBN-10:')
  end

  def scrape_isbn_13
    isbn('ISBN-13:')
  end

  def scrape_image
    @doc.xpath('//tr/td/*[@class="imageborder"]/@src')
  end

  def scrape_price
    price = @doc.xpath('//*[@class="pdpbestpricestyle"]/text()')

    if price
      price.gsub!('$', '')
    else
      price = 0
    end

    price
  end

  def isbn(value)
    @doc.xpath('//*[text()="' + value + '"]/following-sibling::span/a/text()')
  end
end
