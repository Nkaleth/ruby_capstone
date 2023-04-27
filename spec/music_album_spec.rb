require 'rspec'
require './music_album'

describe MusicAlbum do
  it 'Creates Musics Album with date, genre and spotify state' do
    album = MusicAlbum.new(Date.new(2022, 1, 15), true, false)
    expect(album.on_spotify).to be true
    expect(album.publish_date.year).to eq(2022)
  end

  it 'Should can be archived because is on spotify and is older than 10 years' do
    album3 = MusicAlbum.new(Date.new(2000, 1, 15), true, true)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album3.can_be_archived?).to be true
  end

  it 'Should can not be archived because is not on spotify and is older than 10 years' do
    album3 = MusicAlbum.new(Date.new(2000, 1, 15), false, false)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album3.can_be_archived?).to be false
  end

  it 'Should can not be archived because is on spotify and is older than 10 years' do
    album3 = MusicAlbum.new(Date.new(2000, 1, 15), false, false)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album3.can_be_archived?).to be false
  end

  it 'Should can not be archived because is on spotify and is not older than 10 years' do
    album3 = MusicAlbum.new(Date.new(2022, 1, 15), false, false)
    MusicAlbum.send(:public, :can_be_archived?)
    expect(album3.can_be_archived?).to be false
  end
end
