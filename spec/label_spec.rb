require 'spec_helper'
require 'date'

describe Label do
  before :all do
    @label = Label.new('Label', 'red')
    @item = Item.new(Date.new(2012, 6, 24), true)
    @label.add_item(@item)
  end

  describe '#new' do
    it 'Should create an instance of the label class' do
      expect(@label).to be_an_instance_of Label
    end
    it 'Should initialize title as label' do
      expect(@label.title).to eq 'Label'
    end
    it 'Should initialize color as red' do
      expect(@label.color).to eq 'red'
    end
  end

  describe '#add_item' do
    it 'Should add an item to the label items array' do
      expect(@label.instance_variable_get(:@items).length).to be 1
    end
    it 'Should add the label to the item' do
      expect(@item.label.title).to eq 'Label'
      expect(@item.label.color).to eq 'red'
    end
  end
end
