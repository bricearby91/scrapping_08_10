require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

liste_deputes = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))

liste_deputes.xpath("//tbody/tr/td[1]").map do |depute|
	full_name_array=depute.text.strip.split
	prenom_nom = [ full_name_array[1], full_name_array[2] ]
	puts prenom_nom
end






