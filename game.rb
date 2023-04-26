require 'securerandom'
require './item'

class Game < Item
  attr_reader :multiplayer, :last_played_at

  def initialize(publish_date, archived, multiplayer, last_played_at, id = SecureRandom.uuid)
    super(publish_date, archived,id)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    ((Date.today.year - @last_played_at.year) > 2) && super
  end

  def to_json(*_args)
    {
      id: @id,
      publish_date: @publish_date,
      archived: @archived,
      multiplayer: @multiplayer,
      last_played_at: @last_played_at,
      label: @label,
      author: @author,
      genre: @genre
    }.to_json
  end
end
