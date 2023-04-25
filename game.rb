require 'securerandom'
require './item'

class Game < Item
  attr_reader :multiplayer, :last_played_at

  def initialize(publish_date, archived, multiplayer, last_played_at, _id = SecureRandom.uuid)
    super(publish_date, archived)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    ((Date.today.year - @last_played_at.year) > 2) && super
  end
end
game = Game.new(DateTime.new(2001, 2, 3), true, true, DateTime.new(2022, 2, 3))
