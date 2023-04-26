require 'securerandom'
require 'date'
require './item'
require './genre'

class MusicAlbum < Item
  attr_accessor :genre, :on_spotify

  def initialize(publish_date, genre, on_spotify, archived: false)
    super(publish_date, archived, id)
    @on_spotify = on_spotify
    @id = SecureRandom.uuid
    # Use the find_or_create_by_name class method to find or create
    # a Genre object with the given name
    @genre = Genre.find_or_create_by_name(genre)
    @genre.add_item(self)
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
