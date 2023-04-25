require 'rspec'
require './music_album'

describe MusicAlbum do
  it 'Creates Musics Album with date, genre and spotify state' do
    album = MusicAlbum.new('2022-01-15', 'Rock', true)
    expect(album.genre).to eq('Rock')
    expect(album.publish_date.year).to eq(2022)
  end

  it 'Should return true because album has more than 10 years' do
    album2 = MusicAlbum.new('2000-01-15', 'Pop', true)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album2.can_be_archived?).to be true
  end

  it 'Should return false because album should has less than 10 years' do
    album2 = MusicAlbum.new('2020-01-15', 'Pop', true)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album2.can_be_archived?).to be false
  end
end
