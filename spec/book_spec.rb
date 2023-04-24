require 'spec_helper'
require 'date'

describe Book do
  before :all do
    @book = Book.new(Date.new(2020, 4, 25), false, 'Jorge Abrahan', 'good')
  end

  describe '#new' do
    it 'Should create an instance of the book class' do
      expect(@book).to be_an_instance_of Book
    end
    it 'Should initialize date as 2020-04-25' do
      expect(@book.publish_date.month).to eq 4 
      expect(@book.publish_date.day).to eq 25 
      expect(@book.publish_date.year).to eq 2020 
    end
    it 'Should initialize publisher as Jorge Abrahan' do
      expect(@book.publisher).to eq 'Jorge Abrahan'
    end
    it 'Should initialize cover state as good' do
      expect(@book.cover_state).to eq 'good'
    end
  end

  describe '#can_be_archived?' do
    it 'Shouldn\'t be able to be archived since is not older than 10 years and cover state is good' do
      expect(@book.send(:can_be_archived?)).to be_falsy
    end
    it 'Should be able to be archived since cover state is bad' do
      @book_bad = Book.new(Date.new(2020, 4, 25), false, 'Jorge Abrahan', 'bad')
      expect(@book_bad.send(:can_be_archived?)).to be_truthy
    end
  end
end
