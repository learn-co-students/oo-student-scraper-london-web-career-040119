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

  def self.scrape_profile_page(profile_url)
    result = {}

    doc = Nokogiri::HTML(open(profile_url))

    result[:bio] = doc.css('.bio-content .description-holder p').text
    result[:profile_quote] = doc.css('.profile-quote').text

    social_container = doc.css('.social-icon-container a')
    social_container.each do |link|
      url = link.attribute('href').value
      icon = link.css('img').attribute('src').value

      result[:twitter] = url if /twitter/ =~ icon
      result[:github] = url if /github/ =~ icon
      result[:blog] = url if /rss/ =~ icon
      result[:linkedin] = url if /linkedin/ =~ icon
    end

    result
  end
end
