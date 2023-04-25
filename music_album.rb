require 'securerandom'
require './item'

class MusicAlbum < Item
  attr_accessor :genre, :on_spotify

  def initialize(publish_date, archived, genre, on_spotify)
    super(publish_date, archived)
    @genre = genre
    @on_spotify = on_spotify
    @id = SecureRandom.uuid
  end

  private

  def can_be_archived?
    puts 'yes or no?'
  end
end
