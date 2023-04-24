class Label
  attr_reader :id
  attr_accessor :title, :color
  
  def initialize(title, color, id = SecureRandom.uuid)
    @id = id
    @title = title
    @color = color
    @items = []
  end
end
