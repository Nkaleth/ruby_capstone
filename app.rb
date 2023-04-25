require './ask'
require './book'
require './label'
require './store'
require './game'
require './author'
require 'date'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    @games = []
    @authors = []
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
    return puts 'You need to create a label first!' if @labels.empty?

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
      num = display_num ? "#{i}) " : ''
      date = book.publish_date.strftime('%m/%d/%y')
      puts "#{num}Publish date: #{date}, Publisher: #{book.publisher}, Cover state: #{book.cover_state}"
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
      # create and add book to books array
      b = Book.new(Date.new(book['publish_date']['year'], book['publish_date']['month'], book['publish_date']['day']),
                   book['archived'], book['publisher'], book['cover_state'], book['id'])
      @books.push(b)
      # if it has a label
      label_id = book['label_id']
      next if label_id == ''

      # find it's label and add item to label
      label = @labels.find { |l| l.id == label_id }
      label&.add_item(b)
    end
  end

  def load_data
    load_labels
    load_books
  end

  def add_game
    puts '(publish_date, archived, multiplayer, last_played_at)'
    game = Game.new(@ask.date, @ask.boolean('Archived?'), @ask.boolean('Multiplayer?'), @ask.date)
    @games.push(game)
    puts "Game created successfully!\n\n"
  end

  def list_games
    puts "Amount of games: #{@games.length}"
    @games.each do |game|
      puts "Publish_date:#{game.publish_date}, Multiplayer?:#{game.multiplayer}, last_played_at:#{game.last_played_at}"
    end
  end

  def list_authors
    puts "Amount of authors: #{@authors.length}"
    @authors.each do |author|
      puts "First Name: #{author.first_name}, Last Name: #{author.last_name}"
    end
  end
end
