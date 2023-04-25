require 'securerandom'
class Author
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name, items = [], _id = SecureRandom.uuid)
    @first_name = first_name
    @last_name = last_name
    @items = items
  end

  def add_item=(item)
    @items.push(item)
    item.author << self
  end
end
