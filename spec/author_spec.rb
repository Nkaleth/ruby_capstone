require_relative '../author'
require_relative '../item'

describe 'Before all test create an instance of game' do
  before(:all) do
    @item = Item.new(DateTime.new(2001, 2, 3), false)
    @author = Author.new('Sajib', 'Siddiqui')
    @author.add_item(@item)
  end
  it 'test whether an instance of Game' do
    expect(@author).to be_an_instance_of Author
  end
  it 'Shouldn\'t be able to be archived since is not older than 10 years and cover state is good' do
    expect(@author.instance_variable_get(:@items).length).to eq 1
  end
end
