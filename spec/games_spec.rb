require_relative '../game'

describe 'Before all test create an instance of game' do
  before(:all) do
    @game = Game.new(DateTime.new(2001, 2, 3), false, true, DateTime.new(2020, 2, 3))
  end
  it 'test whether an instance of Game' do
    expect(@game).to be_an_instance_of Game
  end
  it 'Shouldn\'t be able to be archived since is not older than 10 years and cover state is good' do
    expect(@game.send(:can_be_archived?)).to be true
  end
end
