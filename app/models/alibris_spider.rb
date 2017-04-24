require 'open-uri'

class AlibrisSpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
    @doc = ''
  end

  def parse
    if @name
      @doc = Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{@name}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
    elsif @isbn_10
      @doc = Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{@isbn_10}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
    else
      @doc = Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{@isbn_13}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
    end
  end

  def scrape_name
    # may possibly need this
    # books = @doc.xpath('//*[@id="selected-works"]/ul/li/a/@href')

    @doc.xpath('//*[@class="product-title"]/h1/text()')
  end

  def scrape_author
    authors = @doc.xpath('//*[@itemprop="author"]/*[@itemprop="name"]/text()')
    authors.join(', ')
  end

  def scrape_isbn_10
    'not provided'
  end

  def scrape_isbn_13
    @doc.xpath('//*[@class="isbn-link"]/text()')
  end

  def scrape_image
    @doc.xpath('//*[@itemprop="image"]/@src')
  end

  def scrape_price
    price = @doc.xpath('//*[@id="tabAll"]/span/text()')
    if price
      price = price.split(' ')
      price = price[1]
      price.gsub!('$', '')
    else
      price = 0
    end

    price
  end
end
