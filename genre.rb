require './item'

class Genre
  attr_reader :id, :items
  attr_accessor :name

  def initialize(name, id = SecureRandom.uuid)
    @name = name
    @id = id
    @items = []
  end

  def add_item(item)
    items << item unless items.include?(item)
    item.genre = self unless item.genre == self
  end
end
