require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    result = []

    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css('.roster-cards-container .student-card')

    student_cards.each do |card|
      student = {}
      student[:name] = card.css('.student-name').text
      student[:location] = card.css('.student-location').text
      student[:profile_url] = card.css('a').attribute('href').value
      result << student
    end

    result
  end

  def self.scrape_profile_page(profile_url); end
end
