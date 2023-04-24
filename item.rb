require 'securerandom'
require 'date'

class Item
  attr_accessor :publish_date
  attr_reader :id, :genre, :author, :source, :label

  def initialize(publish_date, archived, id = SecureRandom.uuid)
    @id = id
    @publish_date = publish_date
    @archived = archived
  end

  # Custom setter methods for many-to-one relationship
  def genre=(genre)
    @genre = genre
    genre.items << self
  end

  def author=(author)
    @author = author
    author.items << self
  end

  def source=(source)
    @source = source
    source.items << self
  end

  def label=(label)
    @label = label
    label.items << self
  end
end
