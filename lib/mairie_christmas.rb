require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


directory_url = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))


def get_townhall_urls(page)
  all_towns_urls = page.xpath("//tr/td/p/a/@href")
  return all_towns_urls
end


townhall_url = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/avernes.html"))


def get_townhall_email(townhall_url)
  return townhall_url.xpath("//section[2]//tr[4]/td[2]").text
end


towns_urls_array = get_townhall_urls(directory_url)

def print_townhalls_emails(towns_urls_array)
email_townname_array = []

  towns_urls_array.each do |address|
	#Getting rid of the full mark and the slash
	new_add = address.to_s
	new_add.slice!("./")
	full_address = "https://www.annuaire-des-mairies.com/" + new_add
	
	#Extracting the townname from the URL
	new_add.slice!("95/")	
	new_add.slice!(".html")
	town_name=new_add.capitalize
	
	#Churning out one hash for each town, inserting it in an array 
	url = Nokogiri::HTML(open(full_address))
	e_mail = get_townhall_email(url)
	hash=Hash.new
	hash[town_name] = e_mail
	email_townname_array << hash
  end
  return email_townname_array
end

puts print_townhalls_emails(towns_urls_array)





