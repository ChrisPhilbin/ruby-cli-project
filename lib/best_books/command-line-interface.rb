class CommandLineInterface
  page_url = 'https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die'

  def make_book_list(page_url = 'https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die')
    book_array = Scraper.scrape_page(page_url)
    Book.create_from_list(book_array)
    Book.all[0..24].each_with_index do |book, index|
      puts "#{index + 1}. #{book.book_title} by #{book.book_author} written in #{book.book_published}"
    end
    input = ''
    while input != 'no'
      puts 'Would you like to print the remainder of the list? (type "yes/no")'
      input = gets.chomp.downcase
      if input == 'yes'
           Book.all[25..-1].each_with_index do |book, index|
             puts "#{index + 26}. #{book.book_title} by #{book.book_author} written in #{book.book_published}"
           end
           break
      end

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

  def get_book_description
    if Book.all.empty?
      puts "Please generate the list first and then try again!"
    else
      puts "Please enter a number from the list in order to view more details about the book:"
      selection = gets.to_i
      if selection.between?(1, 50)
        puts "#{Book.all[selection - 1].book_description}"
      else
        puts "Number is out of range! Please try again!"
      end
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
      puts '##############################################################'
      puts 'Welcome to the best books gem!'
      puts ' '
      puts 'This gem will scrape the website Good Reads and return a current list of their 50 books to read before you die!'
      puts '--------------------------------------------------------------'
      puts 'Please enter a selection based on the below:'
      puts "Enter 'list' to get the most current list of books, in order from best to worst."
      puts "Enter 'desc' to get the description of a book you'd like to find out more about."
      puts "Enter 'random' to get the list, but in random order."
      puts "Enter 'age' to calculate the age of the books"
      puts "Enter 'exit' to exit this program."
      puts '##############################################################'

      user_input = gets.chomp.downcase

      case user_input
      when 'list'
        make_book_list
      when 'desc'
        get_book_description
      when 'random'
        make_random_list
      when 'age'
        set_book_age
      when 'sort'
        sort_by_age
      when 'exit'
        goodbye
       else
       	puts "Invalid selection! Please try again!"
      end
    end
  end
end
