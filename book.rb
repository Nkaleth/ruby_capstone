require 'securerandom'
require 'json'
require './item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, archived, publisher, cover_state, id = SecureRandom.uuid)
    super(publish_date, archived, id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def as_obj
    {
      id: @id,
      publish_date: {
        year: @publish_date.year,
        month: @publish_date.month,
        day: @publish_date.day
      },
      archived: @archived,
      publisher: @publisher,
      cover_state: @cover_state,
      label_id: @label&.id || ''
    }
  end

  def to_json(*_args)
    as_obj.to_json
  end

  private

  def can_be_archived?
    (@cover_state == 'bad' || super)
  end
end
