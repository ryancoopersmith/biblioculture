class PowellsSpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
  end

  def parse
    if @name
      return Nokogiri::HTML(open("http://www.powells.com/SearchResults?kw=title:#{@name}"))
    elsif @isbn_10
      # use mechanize to fill in search bar with isbn_10
    else
      # use mechanize to fill in search bar with isbn_10
    end
  end

    def scrape
      books = response.xpath('//*[@class="width-fixer"]/a/@href').extract()

      name = response.xpath('//*[@class="book-title"]/text()').extract_first()

      authors = response.xpath('//*[@itemprop="author"]/a/text()').extract()
      author = authors.join(', ')

      isbn_10 = 'not provided'
      isbn_13 = response.xpath('//*[@id="seemore"]/p/text()[2]').extract_first()

      image = response.xpath('//*[@id="gallery"]/img/@src').extract_first()

      price = response.xpath('//*[@class="price"]/text()').extract_first()

      if price
        price.gsub!('\\r', '')
        price.gsub!('\\n', '')
        price.gsub!('$', '')
      else
        price = 0
      end
    end
  end
