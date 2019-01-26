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

	def set_book_age
		Book.all.each do |book|
			book.book_age = Time.now.year - self.book_published.to_i
		end
	end


	def call
		user_input = ""

		while user_input != "exit"
			puts "Welcome to the best books gem! This gem will scrape the website Good Reads and return a current list of their 100 books to read before you die!"
			puts "Please enter a selection based on the below:"
			puts "Enter 'list' to get the most current list of books, in order from best to worst."
			puts "Enter 'random' to get the list, but in random order."
			puts "Enter 'exit' to exit this program."

			user_input = gets.chomp

			case user_input
			when "list"
				make_book_list
			when "random"
				make_random_list
			end
	end

end

binding.pry