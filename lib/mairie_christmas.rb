#Gems utiles pour ce programme.
require 'nokogiri'
require 'open-uri'

#Méthode pour récupérer les noms des mairies.
def mairie_names
  page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))
  mairie_name_array = page.xpath('//a[@class="lientxt"]')
  a = scraper(page, mairie_name_array)
  puts a
end

#Méthode pour récupérer les emails des mairies.
def email(mairie_name_array, n)
  lien = mairie_name_array[n]['href'].gsub(/^[\.]/, '')
  page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/#{lien}"))
  mairie_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

#Méthode pour créer un tableau de plusieurs hash{mairie_names => email}
def scraper(page, mairie_name_array)
  a = []
  (0..mairie_name_array.length-1).each {|n|
    hash = {}
    mairie = mairie_name_array[n].text.downcase.gsub(/[\s]/, '_')
    hash[mairie] = email(mairie_name_array, n)
    a << hash
  }
  return a

end

mairie_names