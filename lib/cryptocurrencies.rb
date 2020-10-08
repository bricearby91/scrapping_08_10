require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def collect_currencies(page)
  currencies = []
  page.xpath('//td/div/a[@class="cmc-link"]').map do |currency|
    currencies << currency.inner_text
  end
  return currencies
end

def collect_values(page)
  values = []
  page.xpath('//tbody/tr/td[5]').map do |value|
    values << value.text
  end
  return values
end

currencies=collect_currencies(page)
values=collect_values(page)

def hash_of_arrays(currencies, values)

  final_array = []	
  for i in (0...200) 
    hash = Hash.new
    hash[currencies[i]] = values[i]
    final_array << hash
  end
return final_array
end

puts hash_of_arrays(currencies, values)



