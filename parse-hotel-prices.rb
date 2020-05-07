require 'watir'

browser = Watir::Browser.new

site_to_crawl = 'https://www.expedia.com/Hotel-Search?adults=1&d1=2020-05-07&d2=2020-05-08&destination=Pune&endDate=2020-05-08&latLong=18.456214382543646%2C73.84009240921175&localDateFormat=M%2Fd%2Fyyyy&regionId=6034585&semdtl=&sort=RECOMMENDED&startDate=2020-05-07&theme=&useRewards=true&userIntent'
browser.goto site_to_crawl

hotel_names = Array.new

browser.divs('class': 'uitk-card-content').each do | item |
  hotel = Hash.new
  if item.h3('data-stid': 'content-hotel-title').exist?
    hotel['name'] = item.h3('data-stid': 'content-hotel-title').text
  end

  if hotel['name']
    if item.span('data-stid': 'content-hotel-display-price').span('data-stid': 'content-hotel-lead-price').exist?
      hotel['price'] = item.span('data-stid': 'content-hotel-display-price').span('data-stid': 'content-hotel-lead-price').inner_text
    else
      hotel['price'] = "Not Available"
    end
  end
  if !hotel.empty?
    hotel_names << hotel
  end
end

puts hotel_names

browser.close