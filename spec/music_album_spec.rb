require 'rspec'
require './music_album'

describe MusicAlbum do
  it 'Creates Musics Album with date, genre and spotify state' do
    album = MusicAlbum.new(Date.new(2022, 1, 15), true)
    expect(album.on_spotify).to be true
    expect(album.publish_date.year).to eq(2022)
  end

  it 'Should return true because album has more than 10 years' do
    album2 = MusicAlbum.new(Date.new(2000, 1, 15), true)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album2.can_be_archived?).to be true
  end

  it 'Should return false because album should has less than 10 years' do
    album2 = MusicAlbum.new(Date.new(2020, 1, 15), true)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album2.can_be_archived?).to be false
  end
end
