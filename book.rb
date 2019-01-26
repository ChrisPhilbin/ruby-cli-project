class Book
  
  attr_accessor :book_title, :book_author, :book_published, :book_age

  @@all = []

  def initialize(book_hash)
    book_hash.each do |key, value|
      self.send("#{key}=", value)
      @@all << self
    end
   end

  def self.create_from_list(books)
    books.each do |book_hash|
      Book.new(book_hash)
    end
   end

  def calculate_book_age
    self.all.each do |book|
      book.book_age = Time.now.year - self.book_published.to_i
    end
  end

  def self.all
    @@all
  end
end
