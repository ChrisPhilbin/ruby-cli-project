require_relative '../best_books/scraper.rb'
require_relative '../best_books/book.rb'

require 'nokogiri'

class CommandLineInterface
  page_url = 'https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die'

  def make_book_list(page_url = 'https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die')
    book_array = Scraper.scrape_page(page_url)
    Book.create_from_list(book_array)
    Book.all.each_with_index do |book, index|
      puts "#{index + 1}. #{book.book_title} by #{book.book_author} written in #{book.book_published}"
    end
  end

  def set_book_age
    if Book.all.empty?
      try_again
    else
      Book.all.each do |book|
        book.book_age = Time.now.year - book.book_published.to_i
        puts "#{book.book_title} is #{book.book_age} years old!"
      end
    end
  end

  def make_random_list
    if Book.all.empty?
      try_again
    else
      random_books = Book.all.shuffle
      random_books.each_with_index.map do |book, index|
        puts "#{index + 1}. #{book.book_title} by #{book.book_author}, published in #{book.book_published}"
      end
      random_books
    end
  end

  def try_again
  	puts 'There are no books to shuffle! Please try creating a list first and then try again!'
  end

  def goodbye
    puts 'See you later! Goodbye!'
  end

  def call
    user_input = ''

    while user_input != 'exit'
      puts 'Welcome to the best books gem! This gem will scrape the website Good Reads and return a current list of their 100 books to read before you die!'
      puts 'Please enter a selection based on the below:'
      puts "Enter 'list' to get the most current list of books, in order from best to worst."
      puts "Enter 'random' to get the list, but in random order."
      puts "Enter 'age' to calculate the age of the books"
      puts "Enter 'exit' to exit this program."

      user_input = gets.chomp.downcase

      case user_input
      when 'list'
        make_book_list
      when 'random'
        make_random_list
      when 'age'
        set_book_age
      when 'sort'
      	sort_by_age
      when 'exit'
        goodbye
      end
    end
  end
end
