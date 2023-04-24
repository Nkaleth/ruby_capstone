class Label
  attr_reader :id
  attr_accessor :title, :color, :items

  def initialize(title, color, id = SecureRandom.uuid)
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    item.label = self
  end
end
