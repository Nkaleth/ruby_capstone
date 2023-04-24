class Label
  def initialize(title, color, id = SecureRandom.uuid)
    @id = id
    @title = title
    @color = color
    @items = []
  end
end
