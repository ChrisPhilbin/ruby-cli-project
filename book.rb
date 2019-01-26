class Book
  attr_accessor :book_title, :book_author, :book_published

  @@all = []

  def initialize(book_hash)
    book_hash.each do |key, value|
      send("#{key}=", value)
      @@all << self
    end
   end

  def self.create_from_list(books)
    books.each do |book_hash|
      Book.new(book_hash)
    end
   end

  def self.all
    @@all
  end
end
