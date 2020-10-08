require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

liste_deputes = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))

def collect_deputies_urls(page)
  array_all_urls=page.xpath("//tr/td/a/@href")
  return array_all_urls
end

list_urls_ends = collect_deputies_urls(liste_deputes)	


def forming_valid_urls(list_urls_ends)
deputies_urls_array = []
list_urls_ends.each do |url|
  address = "http://www2.assemblee-nationale.fr" + url.to_s
  deputies_urls_array << address
end
  return deputies_urls_array
end

array_valid_urls = forming_valid_urls(list_urls_ends)


def return_full_name_and_email(array_urls)

final_array = []
array_urls.each do |address|
	individual_page = Nokogiri::HTML(open(address))

	full_name=individual_page.xpath("//div[2]/h1").text.to_s.split
	prenom=full_name[1]
	nom=full_name[2]

	email=individual_page.xpath("//dd[4]/ul/li[2]/a").text.to_s

	hash=Hash.new
	hash["first_name"] = prenom
	hash["last_name"] = nom
	hash["email"] = email
	puts hash	
	final_array << hash
end	
	return final_array
end

#L'affichage se fait progressivement au sein même de la fonction
puts return_full_name_and_email(array_valid_urls)
#Et en dehors, même si c'est beaucoup plus long
