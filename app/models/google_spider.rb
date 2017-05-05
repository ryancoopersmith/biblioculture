require "net/http"

class GoogleSpider
  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
    @doc = ''
  end

  def name
    unfiltered_name = @doc.xpath('//h1[@id="product-name"]/text()').text
    unfiltered_name.gsub(' [Book]', '')
  end

  def author
    unfiltered_author = @doc.xpath('//*[@id="condensed-summary-container"]/div[5]/div/span[1]').text
    if unfiltered_author == ''
      unfiltered_author = @doc.xpath('//*[@id="summary-container"]/div[5]/div/span[1]').text
    end
    unfiltered_author.gsub('by ', '')
  end

  def image
    image = @doc.xpath('//*[@id="condensed-image-cont"]/a/div/img/@src').text
    if image == ''
      image = @doc.xpath('//*[@id="alt-image-cont"]/div/img/@src').text
    end
    image
  end

  def isbn_10
    unfiltered_isbn_10 = @doc.xpath('//span[starts-with(text(),"ISBN")]/text()').text
    unfiltered_isbn_10.gsub('ISBN ', '')
  end

  def find_book
    if @name != ''
      value = @name
    else
      key = ENV["ISBNDB_ACCESS_KEY"]
      if @isbn_10 != ''
        uri = URI("http://www.isbndb.com/api/v2/json/#{key}/book/#{@isbn_10}")
      else
        uri = URI("http://www.isbndb.com/api/v2/json/#{key}/book/#{@isbn_13}")
      end
      response = Net::HTTP.get_response(uri)
      if response.code == "301"
        response = Net::HTTP.get_response(URI.parse(response.header['location']))
      end
      data = JSON.parse(response.body)
      value = data['data'][0]['title']
    end

    agent = Mechanize.new
    page = agent.get('https://www.google.com/')

    search_form = page.form('f')
    search_form.q = "buy #{value} book"
    page = agent.submit(search_form)
    page = agent.page.link_with(text: /^Shop\sfor\sbuy\s.+\son\sGoogle$/).click

    page = agent.page.link_with(text: /^.*\[Book\]$/).click

    if agent.page.link_with(text: /^View\sall\s[0-9]+\sonline\sstores.*$/)
      page = agent.page.link_with(text: /^View\sall\s[0-9]+\sonline\sstores.*$/).click
    end

    page = agent.page.link_with(text: /^.*((R)|(r)){1}efurbished\s*\/\s*used.*$/).click

    if agent.page.search("No matching stores")
      page = agent.page.link_with(text: /^.*((R)|(r)){1}efurbished\s*\/\s*used.*$/).click
    end

    @doc = Nokogiri::HTML(page.content)
  end

  def scrape_prices_and_sites
    prices = []
    sites = @doc.xpath('//tr[@class="os-row"]')

    sites.length.times do |i|
      site = @doc.xpath('//tr[@class="os-row"]/td[@class="os-seller-name"]/span/a/text()')[i].text
      site.gsub!(/\s\-.*/, '')
      price = @doc.xpath('//tr[@class="os-row"]/td[@class="os-total-col"]/text()')[i].text
      price.strip!
      prices.push([site, price])
    end

    prices
  end
end
