#Gems utiles pour ce programme.
require 'nokogiri'
require 'open-uri'

#Méthode pour récupérer les noms des cryptos.
def crypto_names
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  crypto_name_array = page.xpath('//td[contains(@class,"cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol")]//div')
  return crypto_name_array
end

#Méthode pour récupérer les valeurs des cryptos.
def crypto_values
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  devise_price_array = page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price")]//a[contains(@href,"/currencies/")]')
  return devise_price_array
end

#Méthode pour créer un tableau de plusieurs hash{crypto_names => cryto_values}
def scraper
  crypto_name_array = crypto_names
  devise_price_array = crypto_values

  a = []

  for n in 0..crypto_name_array.length-1 do
    a[n] = Hash.new
    a[n][crypto_name_array[n].text] = devise_price_array[n].text.gsub(/[^\d\.]/, '')
  end

  puts a

end

scraper

