require 'spec_helper'
require 'date'

describe Book do
  before :all do
    @book = Book.new(Date.new(2020, 4, 25), false, 'Jorge Abrahan', 'good')
  end
end
