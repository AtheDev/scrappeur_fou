#Gems utiles pour ce programme.
require 'nokogiri'
require 'open-uri'

#Méthode pour récupérer les noms complets des députés.
def depute_names
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  depute_name_array = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')
  a = scraper(page, depute_name_array)
  puts a
end

#Méthode pour récupérer les emails des députés.
def email(depute_name_array, n)
  lien = depute_name_array[n]['href']
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/#{lien}"))
  depute_email = page.xpath('//*[@class="deputes-liste-attributs"]/dd[4]/ul/li[2]/a').text
  return depute_email
end

#Méthode pour créer un tableau de plusieurs hash{depute_first_name => dep[0], depute_last_name => dep[1], email => email(depute_name_array, n)}
def scraper(page, depute_name_array)
  a = []
  (0..depute_name_array.length-1).each {|n|
    hash = {}
    dep = depute_name_array[n].text.gsub(/^([M][\.][\s])|^([M][m][e])[\s]/, '').split(' ', 2)
    hash["first_name"] = dep[0]
    hash["last_name"] = dep[1]
    hash["email"] = email(depute_name_array, n)
    a << hash
  }
  return a

end

depute_names