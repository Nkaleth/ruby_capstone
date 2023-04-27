require './store'
require './label'
require './book'
require './author'
require './game'

module Load
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
      @authors.push(Author.new(author['first_name'], author['last_name'], author['id']))
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
      label = @labels.find { |l| l.id == label_id }
      label&.add_item(game_instance)
    end
  end

  def load_albums
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
