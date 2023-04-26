require 'securerandom'
require 'date'
require './item'

class MusicAlbum < Item
  attr_accessor :genre, :on_spotify

  def initialize(publish_date, on_spotify, archived, id = SecureRandom.uuid)
    super(publish_date, archived, id)
    @on_spotify = on_spotify
  end

  def as_obj
    {
      id: @id,
      publish_date: {
        year: @publish_date.year,
        month: @publish_date.month,
        day: @publish_date.day
      },
      on_spotify: @on_spotify,
      archived: @archived,
      label_id: @label&.id || ''
    }
  end

  def to_json(*_args)
    as_obj.to_json
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
