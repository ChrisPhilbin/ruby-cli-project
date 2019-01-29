require 'nokogiri'
require 'open-uri'
require 'pry'

# "https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die"

class Scraper
  def self.scrape_page(page_url)
    books_array = []

    page = Nokogiri::HTML(open(page_url))
    page.css('div.leftContainer').each do |container|
      container.css('div.elementList').each do |element|
        title = element.css('a.leftAlignedImage').attr('title').text
        author = element.css('div.authorName__container a').text
        published = element.css('span.greyText').text.gsub(/\s+/, '')[-4..-1]
        books_array << { book_title: title, book_author: author, book_published: published }
      end
    end
    books_array
  end
end
