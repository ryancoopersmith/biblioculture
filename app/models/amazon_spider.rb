require 'open-uri'

class AmazonSpider
  attr_accessor :name, :isbn_10, :isbn_13

  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
  end

  def parse
    if @name
      return Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{@name}"))
    elsif @isbn_10
      return Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{@isbn_10}"))
    else
      return Nokogiri::HTML(open("https://www.amazon.com/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=#{@isbn_13}"))
    end
  end

  def scrape
    books = response.xpath('//a[contains(@class, "a-link-normal") and contains(@class, "s-access-detail-page")]/@href').extract()

    name = response.xpath('//span[@id="productTitle"]/text()').extract_first()
    if !name
      name = response.xpath('//span[@id="ebooksProductTitle"]/text()').extract_first()
    end

    authors = []

    roles = response.xpath('//*[@id="byline"]/span/span/span/text()').extract()

    if roles.length > 0
      if roles[0].include?('Author')
        author1 = response.xpath('//*[@id="byline"]/span/span/a/text()|//*[@id="byline"]/span/a/text()')[0].extract()
        authors.push(author1)
      end
    end

    if roles.length > 1
      if roles[1].include?('Author')
        author2 = response.xpath('//*[@id="byline"]/span/span/a/text()|//*[@id="byline"]/span/a/text()')[1].extract()
        authors.push(author2)
      end
    end

    if roles.length > 2
      if roles[2].include?('Author')
        author3 = response.xpath('//*[@id="byline"]/span/span/a/text()|//*[@id="byline"]/span/a/text()')[2].extract()
        authors.push(author3)
      end
    end

    author = authors.join(', ')

    if author == ''
      author = 'not provided'
    end

    isbn_10 = isbn(response, 3)
    isbn_13 = isbn(response, 4)

    image = response.xpath('//*[@id="imgBlkFront"]/@data-a-dynamic-image').extract_first()

    if !image
      image = response.xpath('//*[@id="ebooksImgBlkFront"]/@data-a-dynamic-image').extract_first()
    end

    image.gsub!(/\":.*/, '')
    image.gsub!(/{\"/, '')

    if response.xpath('//*[@class="olp-used olp-link"]/a/text()').extract()
      used_price = response.xpath('//*[@class="olp-used olp-link"]/a/text()')[1].extract()
      used_price.gsub!(/\\n.*/, '')
      used_price.gsub!('$', '')
      used_price_compare = used_price.to_f
    else
      used_price_compare = 0
      used_price = 0
    end

    if response.xpath('//*[@class="olp-new olp-link"]/a/text()').extract()
      new_price = response.xpath('//*[@class="olp-new olp-link"]/a/text()')[1].extract()
      new_price.gsub!(/\\n.*/, '')
      new_price.gsub!('$', '')
      new_price_compare = new_price.to_f
    else
      new_price_compare = 0
      new_price = 0
    end

    if response.xpath('//*[@class="a-section a-spacing-small a-spacing-top-small"]/span/span/text()').extract()
      new_price = response.xpath('//*[@class="a-section a-spacing-small a-spacing-top-small"]/span/span/text()')[0].extract()
      used_price = response.xpath('//*[@class="a-section a-spacing-small a-spacing-top-small"]/span/span/text()')[1].extract()
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
  end

  def isbn(response, value)
    if response.xpath('//*[@class="content"]/ul/li/text()')[value].extract() == ' English' || (response.xpath('//*[@class="content"]/ul/li/text()')[value - 1].extract() == ' English' && value == 4)
      value += 1
    end

    alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
      'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
      'w', 'x', 'y', 'z']

    alphabet.each do |letter|
      if letter == response.xpath('//*[@class="content"]/ul/li/text()')[value].extract()[3]
        return 'not provided'
      end
    end

    return response.xpath('//*[@class="content"]/ul/li/text()')[value].extract()
  end
end
