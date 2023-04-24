require 'securerandom'
require 'date'

class Item
  attr_accessor :publish_date
  attr_reader :id, :genre, :author, :source, :label

  def initialize(publish_date, archived, id = SecureRandom.uuid)
    @id = id
    @publish_date = publish_date
    @archived = archived
  end
end
