require './ask'
require './book'
require './game'
require './author'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    @games = []
    @authors = []
    @ask = Ask.new
  end

  def add_book
    book = Book.new(@ask.date, @ask.boolean('Archived?'), @ask.string('Publisher'),
                    @ask.option('Cover state', %w[good bad]))
    @books.push(book)
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
