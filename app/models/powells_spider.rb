require 'open-uri'

class PowellsSpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
    @doc = ''
  end

  def parse
    if @name
      @doc = Nokogiri::HTML(open("http://www.powells.com/SearchResults?kw=title:#{@name}"))
    elsif @isbn_10
      # use mechanize to fill in search bar with isbn_10
    else
      # use mechanize to fill in search bar with isbn_10
    end
  end

  def scrape_name
    # may possibly need this
    # books = @doc.xpath('//*[@class="width-fixer"]/a/@href')

    @doc.xpath('//*[@class="book-title"]/text()')
  end

  def scrape_author
    authors = @doc.xpath('//*[@itemprop="author"]/a/text()')
    authors.join(', ')
  end

  def scrape_isbn_10
    'not provided'
  end

  def scrape_isbn_13
    @doc.xpath('//*[@id="seemore"]/p/text()[2]')
  end

  def scrape_image
    @doc.xpath('//*[@id="gallery"]/img/@src')
  end

  def scrape_price
    @doc.xpath('//*[@class="price"]/text()')

    if price
      price.gsub!('\\r', '')
      price.gsub!('\\n', '')
      price.gsub!('$', '')
    else
      price = 0
    end

    price
  end
end
