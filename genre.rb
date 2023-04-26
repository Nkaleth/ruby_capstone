require './item'

class Genre
  attr_reader :id, :items
  attr_accessor :name

  def initialize(name, id = SecureRandom.uuid)
    @name = name
    @id = id
    @items = []
  end

  def as_obj
    {
      id: @id,
      name: @name
    }
  end

  def to_json(*_args)
    as_obj.to_json
  end

  def add_item(item)
    items << item unless items.include?(item)
    item.genre = self unless item.genre == self
  end
end
