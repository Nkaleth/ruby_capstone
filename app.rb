require './ask'
require './book'
require './store'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    @ask = Ask.new
    @store = Store.new
  end

  def add_book
    @books.push(Book.new(@ask.date, @ask.boolean('Archived?'), @ask.string('Publisher'),
                         @ask.option('Cover state', %w[good bad])))
    puts "Book created successfully!\n\n"
  end

  def list_books
    puts "Amount of books: #{@books.length}"
    @books.each do |book|
      puts "Publish date: #{book.publish_date}, Publisher: #{book.publisher}, Cover state: #{book.cover_state}"
    end
  end

  def list_labels
    puts "Amount of labels: #{@labels.length}"
    @labels.each do |label|
      puts "Title: #{label.title}, Color: #{label.color}"
    end
  end

  def save_data
    @store.write(@books, 'books.json')
    @store.write(@labels, 'labels.json')
  end
end
