class GoogleSpider
  def initialize(options = {})
    @name = options[:name] || ''
    @isbn_10 = options[:isbn_10] || ''
    @isbn_13 = options[:isbn_13] || ''
    @parsed_page = ''
  end

  def name
    unfiltered_name = @parsed_page.xpath('//h1[@id="product-name"]/text()').text
    unfiltered_name.gsub(' [Book]', '')
  end

  def author
    unfiltered_author = @parsed_page.xpath('//*[@id="summary-container"]/div[5]/div/span[1]').text
    unfiltered_author.gsub('by ', '')
  end

  def image
    @parsed_page.xpath('//*[@id="alt-image-cont"]/div/img/@src').text
  end

  def isbn_10
    unfiltered_isbn_10 = @parsed_page.xpath('//span[starts-with(text(),"ISBN")]/text()').text
    unfiltered_isbn_10.gsub('ISBN ', '')
  end

  def find_book
    if @name
      value = @name
    elsif @isbn_10
      value = @isbn_10
    else
      value = @isbn_13
    end

    agent = Mechanize.new
    page = agent.get('https://www.google.com/')

    search_form = page.form('f')
    search_form.q = "buy #{value} book"
    page = agent.submit(search_form)
    page = agent.page.link_with(text: "Shop for buy #{value} book on Google").click

    page = agent.page.link_with(text: /^.*\[Book\]$/).click
    page = agent.page.link_with(text: /^View\sall\s[0-9]+\sonline\sstores.*$/).click
    page = agent.page.link_with(text: /^.*((R)|(r)){1}efurbished\s*\/\s*used.*$/).click
    @parsed_page = Nokogiri::HTML(page.content)
  end

  def scrape_prices_and_sites
    prices = []
    sites = @parsed_page.xpath('//tr[@class="os-row"]')

    sites.length.times do |i|
      site = @parsed_page.xpath('//tr[@class="os-row"]/td[@class="os-seller-name"]/span/a/text()')[i].text
      site.gsub!(/\s\-.*/, '')
      price = @parsed_page.xpath('//tr[@class="os-row"]/td[@class="os-total-col"]/text()')[i].text
      price.strip!
      prices.push([site, price])
    end

    prices
  end
end
