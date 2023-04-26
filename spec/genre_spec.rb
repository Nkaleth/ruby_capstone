require 'rspec'
require './genre'

describe Genre do
  let(:item1) { double('Item') }
  let(:item2) { double('Item') }

  before do
    allow(item1).to receive(:genre)
    allow(item1).to receive(:genre=)
    allow(item2).to receive(:genre)
    allow(item2).to receive(:genre=)
  end

  it 'Creates a new Genre' do
    genre1 = Genre.new('Rock')
    expect(genre1.name).to eq('Rock')
    expect(genre1.id).not_to be_nil
  end

  it 'Add many items to a genre' do
    genre2 = Genre.new('Pop')
    genre2.add_item(item1)
    genre2.add_item(item2)
    expect(genre2.items).to include(item1, item2)
  end

  it 'Does not add the same item more than 1' do
    genre3 = Genre.new('Indie')
    genre4 = Genre.new('Indie')
    genre3.add_item(item1)
    genre4.add_item(item1)
    expect(genre3.items.count).to eq(1)
  end
end
