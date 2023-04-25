require 'rspec'
require './music_album'

describe MusicAlbum do
  it 'Creates Musics Album with date, genre and spotify state' do
    album = MusicAlbum.new('2022-01-15', 'Rock', true)
    expect(album.genre).to eq('Rock')
    expect(album.publish_date.year).to eq(2022)
  end
end
