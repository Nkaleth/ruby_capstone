require './item'

class Genre
  attr_reader :id, :items
  attr_accessor :name

  # class variable to keep track of existing Genre objects
  @genres = {}

  def initialize(name, id = SecureRandom.uuid)
    @name = name
    @id = id
    @items = []
    # Add the new Genre object to the genres collection if it doesn't already exist
    self.class.genres[name] ||= self
  end

  def add_item(item)
    items << item unless items.include?(item)
    item.genre = self unless item.genre == self
  end

  # Define a class method to find or create a Genre object with the given name
  def self.find_or_create_by_name(name)
    genres[name] || Genre.new(name)
  end

  # Define a class method to access the genres collection
  class << self
    attr_reader :genres
  end
end
