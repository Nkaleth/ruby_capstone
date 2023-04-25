require './ask'
require './book'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    @ask = Ask.new
  end

  def add_book
    book = Book.new(@ask.date, @ask.boolean('Archived?'), @ask.string('Publisher'), @ask.string('Cover state'))
    @books.push(book)
    puts "Book created successfully!\n\n"
  end
end
