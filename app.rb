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

  def list_books
    puts "Amount of books: #{@books.length}"
    @books.each do |book|
      puts "Publish date: #{book.publish_date}, Publisher: #{book.publisher}, Cover state: #{book.cover_state}"
      p book
    end
  end

  def list_labels
    puts "Amount of labels: #{@labels.length}"
    @labels.each do |label|
      puts "Title: #{label.title}, Color: #{label.color}"
    end
  end
end
