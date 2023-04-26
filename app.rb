require './ask'
require './book'
require './label'
require './store'
require './game'
require './author'
require './music_album'
require 'date'
require './load'

class App
  attr_accessor :books, :labels


  def initialize
    @labels = []
    @books = []
    @authors = []
    @games = []
    @music_albums = []
    @genres = []
    @ask = Ask.new
    @store = Store.new
  end
  include Load
  def add_book
    @books.push(Book.new(@ask.date, @ask.boolean('Archived?'), @ask.string('Publisher'),
                         @ask.option('Cover state', %w[good bad])))
    puts "Book created successfully!\n\n"
  end

  def add_label
    @labels.push(Label.new(@ask.string('Title'), @ask.string('Color')))
    puts "Label created successfully\n\n"
  end

  def add_game
    puts '(publish_date, archived, multiplayer, last_played_at)'
    game = Game.new(@ask.date, @ask.boolean('Archived?'), @ask.boolean('Multiplayer?'), @ask.date)
    @games.push(game)
    puts "Game created successfully!\n\n"
  end

  def add_author
    puts '(first_name, last_name)'
    @labels.push(Author.new(@ask.string('first_name'), @ask.string('last_name')))
    puts "New author created successfully\n\n"
  end

  def add_author_to_item
    return puts 'You need to create an author  first!' if @authors.empty?

    category = @ask.option('Which item you want to add a author to', %w[book album game])
    puts 'Choose the item'
    array = display_label_options(category)
    return puts 'There are no items of that category at the moment!' if array.empty?

    item_index = @ask.number_between(array.length - 1)
    puts 'Choose the author'
    list_authors(display_num: true)
    author_index = @ask.number_between(@labels.length - 1)
    @authors[author_index].add_item(array[item_index])
    puts "Author has been added to that item!\n\n"
  end

  def add_music_album
    puts '(publish_date, genre, on_spotify)'
    music_album = MusicAlbum.new(@ask.date, @ask.boolean('On Spotify?'), @ask.boolean('Archived?'))
    @music_albums.push(music_album)
    puts "Music album created successfully!\n\n"
  end

  def display_label_options(category)
    case category
    when 'book' then list_books(display_num: true)
                     @books
    when 'album' then list_music_albums(display_num: true)
                      @music_albums
    when 'game' then list_games(display_num: true)
                     @games
    else
      []
    end
  end

  def assign_item_to_label
    return puts 'You need to create a label first!' if @labels.empty?

    category = @ask.option('Select the item you want to add a label to', %w[book album game])
    array = display_label_options(category)
    return puts 'There are no items of that category at the moment!' if array.empty?

    item_index = @ask.number_between(array.length - 1)
    puts 'Choose the label'
    list_labels(display_num: true)
    label_index = @ask.number_between(@labels.length - 1)
    @labels[label_index].add_item(array[item_index])
    puts "Item added to label successfully!\n\n"
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

  def list_games(display_num: false)
    puts "Amount of games: #{@games.length}" unless display_num
    @games.each_with_index do |game, i|
      num = display_num ? "#{i}) " : ''
      puts "#{num} Published:#{game.publish_date},Multiplayer?:#{game.multiplayer}, last_played:#{game.last_played_at}"
    end
  end

  def list_authors
    puts "Amount of authors: #{@authors.length}"
    @authors.each_with_index do |author, _i|
      puts "First Name: #{author.first_name}, Last Name: #{author.last_name}"
    end
  end

  def list_music_albums(display_num: false)
    puts "Amount of music albums: #{@music_albums.length}" unless display_num
    @music_albums.each_with_index do |music_album, i|
      num = display_num ? "#{i}) " : ''
      puts "#{num}Publish_date: #{music_album.publish_date}, On_spotify: #{music_album.on_spotify}"
    end
  end

  def list_genres(display_num: false)
    puts "Amount of genres: #{@genres.length}" unless display_num
    @genres.each_with_index do |genre, i|
      puts "#{display_num ? "#{i}) " : ''}Genre Name: #{genre.name}"
    end
  end

  def save_data
    @store.write(@books, 'books.json')
    @store.write(@labels, 'labels.json')
    @store.write(@games, 'games.json')
    @store.write(@authors, 'authors.json')
    @store.write(@music_albums, 'music_albums.json')
    @store.write(@genres, 'genres.json')
  end

  def load_data
    labels
    load_books
    authors
    games
    albums
  end
end
