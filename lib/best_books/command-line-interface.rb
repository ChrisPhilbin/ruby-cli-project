require_relative "../best_books/scraper.rb"
require_relative "../best_books/book.rb"

require 'nokogiri'
require 'pry'

class CommandLineInterface

	page_url = "https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die"

	def self.make_book_list(page_url = "https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die")
		book_array = Scraper.scrape_page(page_url)
		Book.create_from_list(book_array)
		Book.all.each_with_index do |book, index|
			puts "#{index+1}. #{book.book_title} by #{book.book_author} written in #{book.book_published}"
		end
	end

	def self.set_book_age
		Book.all.each do |book|
			book.book_age = Time.now.year - self.book_published.to_i
		end
	end

	def self.make_random_list
		random_books = Book.all.shuffle
		random_books.each_with_index.map do |book, index|
			puts "#{index}. #{book.book_title} by #{book.book_author}, published in #{book.book_published}"
		end
		random_books
	end

	def self.goodbye
		puts "See you later! Goodbye!"
	end

	def call
		user_input = ""

		while user_input != "exit"
			puts "Welcome to the best books gem! This gem will scrape the website Good Reads and return a current list of their 100 books to read before you die!"
			puts "Please enter a selection based on the below:"
			puts "Enter 'list' to get the most current list of books, in order from best to worst."
			puts "Enter 'random' to get the list, but in random order."
			puts "Enter 'exit' to exit this program."

			user_input = gets.chomp.downcase

			case user_input
			when "list"
				CommandLineInterface.make_book_list
			when "random"
				CommandLineInterface.make_random_list
			when "exit"
				CommandLineInterface.goodbye
			end
		end
	end
end