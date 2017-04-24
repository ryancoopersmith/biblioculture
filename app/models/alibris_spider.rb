class AlibrisSpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
  end

  def parse
    if @name
      return Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{@name}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
    elsif @isbn_10
      return Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{@isbn_10}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
    else
      return Nokogiri::HTML(open("http://www.alibris.com/booksearch?keyword=#{@isbn_13}&mtype=B&hs.x=0&hs.y=0&hs=Submit"))
    end
  end

  def scrape
    books = response.xpath('//*[@id="selected-works"]/ul/li/a/@href').extract()

    name = response.xpath('//*[@class="product-title"]/h1/text()').extract_first()

    authors = response.xpath('//*[@itemprop="author"]/*[@itemprop="name"]/text()').extract()
    author = authors.join(', ')

    isbn_10 = 'not provided'
    isbn_13 = response.xpath('//*[@class="isbn-link"]/text()').extract_first()

    image = response.xpath('//*[@itemprop="image"]/@src').extract_first()

    price = response.xpath('//*[@id="tabAll"]/span/text()').extract_first()
    if price
      price = price.split(' ')
      price = price[1]
      price.gsub!('$', '')
    else
      price = 0
    end
  end
end
