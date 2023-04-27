require 'securerandom'
class Author
  attr_accessor :first_name, :last_name
  attr_reader :items

  def initialize(first_name, last_name, items = [], id = SecureRandom.uuid)
    @first_name = first_name
    @last_name = last_name
    @items = items
    @id = id
  end

  def add_item(item)
    item.author = self
  end

  def to_json(*_args)
    {
      id: @id,
      first_name: @first_name,
      last_name: @last_name,
      items: @items.map(&:to_json)
    }.to_json
  end
end
