require './ask'
require './book'
require './label'
require './store'
require './game'
require './author'
require './music_album'
require 'date'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    @games = []
    @authors = []
    @music_albums = []
    @genres = []
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
    puts "Label created successfully\n\n"
  end

  def display_label_options(category)
    if category == 'book'
      list_books(display_num: true)
      return @books
    end
    if category == 'album'
      list_music_albums(display_num: true)
      return @music_albums
    end
    if category == 'game'
      list_games(display_num: true)
      print 'Game selected'
      return @games
    end
    []
  end

  def add_label_to_item
    return puts 'You need to create a label first!' if @labels.empty?

    category = @ask.option('Which item you want to add a label to', %w[book album game])
    puts 'Choose the item'
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

  def save_data
    @store.write(@books, 'books.json')
    @store.write(@labels, 'labels.json')
    @store.write(@games, 'games.json')
    @store.write(@authors, 'authors.json')
    @store.write(@music_albums, 'music_albums.json')
    @store.write(@genres, 'genres.json')
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

  def load_authors
    @store.read('authors.json').each do |author|
      @labels.push(Author.new(author['first_name'], author['last_name'], author['id']))
    end
  end

  def load_games
    @store.read('games.json').each do |game|
      # create and add book to books array
      game_instance = Game.new(game['publish_date'], game['archived'], game['multiplayer'],
                                 game['last_played_at'], game['id'])
      @games.push(game_instance)
      # if it has a label
      label_id = game['label']
      author_id = game['author']
      genre_id = game['genre']

      # find it's label and add item to label
      label = @labels.find { |l| l.id == label_id }
      label&.add_item(game_instance)
      author = @authors.find { |a| a.id == author_id }
      author&.add_item(game_instance)
      genre = @genres.find { |g| g.id == genre_id }
      genre&.add_item(game_instance)
    end
  end

  def load_data
    load_labels
    load_books
    load_authors
    load_games
    load_music_albums
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

  def list_games
    puts "Amount of games: #{@games.length}"
    @games.each do |game|
      puts "Publish_date:#{game.publish_date}, Multiplayer?:#{game.multiplayer}, last_played_at:#{game.last_played_at}"
    end
  end

  def list_authors(display_num: false)
    puts "Amount of authors: #{@authors.length}" unless display_num
    @authors.each_with_index do |author, i|
      puts "#{i + 1} First Name: #{author.first_name}, Last Name: #{author.last_name}"
    end
  end

  # Music Album section

  def add_music_album
    puts '(publish_date, genre, on_spotify)'
    music_album = MusicAlbum.new(@ask.date, @ask.boolean('On Spotify?'))
    @music_albums.push(music_album)
    puts "Music album created successfully!\n\n"
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

  def load_music_albums
    @store.read('music_albums.json').each do |album|
      # create and add album to music_albums array
      b = MusicAlbum.new(Date.new(album['publish_date']['year'], album['publish_date']['month'],
                                  album['publish_date']['day']), album['on_spotify'], album['archived'], album['id'])
      @music_albums.push(b)
      # if it has a label
      label_id = album['label_id']
      next if label_id == ''

      # find it's label and add item to label
      label = @labels.find { |l| l.id == label_id }
      label&.add_item(b)
    end
  end

  def load_genres
    @store.read('genres.json').each do |genre|
      @genres.push(genre.new(genre['name'], genre['id']))
    end
  end
end
