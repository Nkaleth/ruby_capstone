require 'securerandom'
require 'date'
require './item'

class MusicAlbum < Item
  attr_accessor :genre, :on_spotify

  def initialize(publish_date, genre, on_spotify, archived: false)
    super(publish_date, archived, id)
    @genre = genre
    @on_spotify = on_spotify
    @id = SecureRandom.uuid
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
