require './ask'
require './book'
require './label'
require './store'
require 'date'

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

  def add_label
    @labels.push(Label.new(@ask.string('Title'), @ask.string('Color')))
  end

  def display_label_options(category)
    if category == 'book'
      list_books(display_num: true)
      return @books
    end
    if category == 'album'
      # list_albums(display_num: true)
      # return @albums
      print 'Album selected'
    end
    if category == 'game'
      # list_games(display_num: true)
      # return @games
      print 'Game selected'
    end
    []
  end

  def add_label_to_item
    return puts 'You need to create a label first!' if @labels.length == 0

    category = @ask.option('Which item you want to add a label to', %w[book album game])
    puts 'Choose the item'
    array = display_label_options(category)
    item_index = @ask.number_between(array.length - 1)
    puts 'Choose the label'
    list_labels(display_num: true)
    label_index = @ask.number_between(@labels.length - 1)
    @labels[label_index].add_item(array[item_index])
    puts 'Item added to label successfully!'
  end

  def list_books(display_num: false)
    puts "Amount of books: #{@books.length}" unless display_num
    @books.each_with_index do |book, i|
      puts "#{display_num ? "#{i}) " : ''}Publish date: #{book.publish_date.strftime("%m/%d/%y")}, Publisher: #{book.publisher}, Cover state: #{book.cover_state}"
    end
  end

  def list_labels(display_num: false)
    puts "Amount of labels: #{@labels.length}" unless display_num
    @labels.each_with_index do |label, i|
      puts "#{display_num ? "#{i}) " : ''}Title: #{label.title}, Color: #{label.color}"
    end
  end

  def save_data
    @store.write(@books, 'books.json')
    @store.write(@labels, 'labels.json')
  end

  def load_labels
    @store.read('labels.json').each do |label|
      @labels.push(Label.new(label['title'], label['color'], label['id']))
    end
  end

  def load_books
    @store.read('books.json').each do |book|
      @books.push(Book.new(Date.new(book['publish_date']['year'], book['publish_date']['month'], book['publish_date']['day']), book['archived'], book['publisher'], book['cover_state'], book['id']))
    end
  end

  def load_data
    load_labels
    load_books
  end
end
