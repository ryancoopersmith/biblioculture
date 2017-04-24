require 'open-uri'

class AmazonSpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
    @doc = ''
  end

  def parse
    if @name
      @doc = Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{@name}"))
    elsif @isbn_10
      @doc = Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{@isbn_10}"))
    else
      @doc = Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{@isbn_13}"))
    end
  end

  def scrape_name
    # may possibly need this
    # books = @doc.xpath('//a[contains(@class, "a-link-normal") and contains(@class, "s-access-detail-page")]/@href')

    name = @doc.xpath('//span[@id="productTitle"]/text()')
    if !name
      name = @doc.xpath('//span[@id="ebooksProductTitle"]/text()')
    end

    name
  end

  def scrape_author
    authors = []

    roles = @doc.xpath('//*[@id="byline"]/span/span/span/text()')

    if roles.length > 0
      if roles[0].include?('Author')
        author1 = @doc.xpath('//*[@id="byline"]/span/span/a/text()|//*[@id="byline"]/span/a/text()')[0]
        authors.push(author1)
      end
    end

    if roles.length > 1
      if roles[1].include?('Author')
        author2 = @doc.xpath('//*[@id="byline"]/span/span/a/text()|//*[@id="byline"]/span/a/text()')[1]
        authors.push(author2)
      end
    end

    if roles.length > 2
      if roles[2].include?('Author')
        author3 = @doc.xpath('//*[@id="byline"]/span/span/a/text()|//*[@id="byline"]/span/a/text()')[2]
        authors.push(author3)
      end
    end

    author = authors.join(', ')

    if author == ''
      author = 'not provided'
    end

    author
  end

  def scrape_isbn_10
    isbn(3)
  end

  def scrape_isbn_13
    isbn(4)
  end

  def scrape_image
    image = @doc.xpath('//*[@id="imgBlkFront"]/@data-a-dynamic-image')

    if !image
      image = @doc.xpath('//*[@id="ebooksImgBlkFront"]/@data-a-dynamic-image')
    end

    image.gsub!(/\":.*/, '')
    image.gsub!(/{\"/, '')

    image
  end

  def scrape_price
    if @doc.xpath('//*[@class="olp-used olp-link"]/a/text()')
      used_price = @doc.xpath('//*[@class="olp-used olp-link"]/a/text()')[1]
      used_price.gsub!(/\\n.*/, '')
      used_price.gsub!('$', '')
      used_price_compare = used_price.to_f
    else
      used_price_compare = 0
      used_price = 0
    end

    if @doc.xpath('//*[@class="olp-new olp-link"]/a/text()')
      new_price = @doc.xpath('//*[@class="olp-new olp-link"]/a/text()')[1]
      new_price.gsub!(/\\n.*/, '')
      new_price.gsub!('$', '')
      new_price_compare = new_price.to_f
    else
      new_price_compare = 0
      new_price = 0
    end

    if @doc.xpath('//*[@class="a-section a-spacing-small a-spacing-top-small"]/span/span/text()')
      new_price = @doc.xpath('//*[@class="a-section a-spacing-small a-spacing-top-small"]/span/span/text()')[0]
      used_price = @doc.xpath('//*[@class="a-section a-spacing-small a-spacing-top-small"]/span/span/text()')[1]
      new_price.gsub!('$', '')
      used_price.gsub!('$', '')
      new_price_compare = new_price.to_f
      used_price_compare = used_price.to_f
    end

    if used_price_compare <= new_price_compare
      price = used_price
    else
      price = new_price
    end

    price
  end

  def isbn(value)
    if @doc.xpath('//*[@class="content"]/ul/li/text()')[value] == ' English' || (@doc.xpath('//*[@class="content"]/ul/li/text()')[value - 1] == ' English' && value == 4)
      value += 1
    end

    alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
      'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
      'w', 'x', 'y', 'z']

    alphabet.each do |letter|
      if letter == @doc.xpath('//*[@class="content"]/ul/li/text()')[value][3]
        return 'not provided'
      end
    end

    @doc.xpath('//*[@class="content"]/ul/li/text()')[value]
  end
end
