require './ask'

class App
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    @ask = Ask.new
  end
end
