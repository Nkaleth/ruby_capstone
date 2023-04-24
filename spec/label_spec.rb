require 'spec_helper'

describe Label do
  before :all do
    @label = Label.new('Label', 'red')
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
end
