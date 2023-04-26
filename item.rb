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
  def add_genre=(genre)
    @genre = genre
    genre.items << self
  end

  def add_author=(author)
    @author = author
    author.items << self
  end

  def add_label=(label)
    @label = label
    label.items << self
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    ((Date.today.year - @publish_date.year) > 10)
  end
end
