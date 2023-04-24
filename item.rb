class Item
  attr_accessor :publish_date
  attr_reader :id
  attr_writer :genre, :author, :source, :label

  def initialize(publish_date, archive)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archive = archive
  end
  
end
