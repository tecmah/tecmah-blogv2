require 'open-uri'
require 'nokogiri'


# APIを使用するべきか、スクレイピングを使用するべきか
url = 'https://twitter.com/explore/tabs/trending'
document = Nokogiri::HTML(URI.open(url))

trends = document.css('.trend-item .content a').map do |element|
  element.text
end

puts trends

