require_relative "../ruby-cli-project/scraper.rb"
require_relative "../ruby-cli-project/book.rb"

require 'nokogiri'
require 'pry'

class CommandLineInterface

	page_url = "https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die"

	def make_book_list(page_url)
		book_array = Scraper.scrape_page(page_url)
		Book.create_from_list(book_array)
	end

end

binding.pry