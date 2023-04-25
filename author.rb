require 'securerandom'
class Author
  attr_accessor :first_name, :last_name
  attr_reader :items

  def initialize(first_name, last_name, items = [], _id = SecureRandom.uuid)
    @first_name = first_name
    @last_name = last_name
    @items = items
  end

  def add_item(item) 
    item.author = self
  end
end
