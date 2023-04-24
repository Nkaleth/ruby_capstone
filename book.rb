require 'securerandom'
require './item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, archived, publisher, cover_state, id = SecureRandom.uuid)
    super(publish_date, archived, id)
    @publisher = publisher
    @cover_state = cover_state
  end

  private

  def can_be_archived?
    (@cover_state == 'bad' || super)
  end
end
