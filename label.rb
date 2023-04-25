class Label
  attr_reader :id
  attr_accessor :title, :color, :items

  def initialize(title, color, id = SecureRandom.uuid)
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def as_json
    {
      id: @id,
      title: @title,
      color: @color
    }
  end

  def to_json(*_args)
    as_json.to_json
  end

  def add_item(item)
    item.label = self
  end
end
