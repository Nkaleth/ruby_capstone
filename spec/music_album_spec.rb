require 'rspec'
require './music_album'

describe MusicAlbum do
  let(:publish_date) { Date.new(2000, 10, 1) }
  let(:genre) { 'Rock' }
  let(:on_spotify) { true }
  let(:archived) { false }
  let(:music_album) { MusicAlbum.new(publish_date, genre, on_spotify, archived: archived) }

  describe '#initialize' do
    it 'creates a new MusicAlbum object with the given attributes' do
      expect(music_album).to be_a(MusicAlbum)
      expect(music_album.publish_date).to eq(publish_date)
      expect(music_album.genre.name).to eq(genre)
    end

    it 'adds the new album to the items array of the Genre object' do
      expect(music_album.genre.items).to include(music_album)
    end
  end

  describe '#can_be_archived?' do
    context 'when the album is on Spotify' do
      let(:on_spotify) { true }

      it 'returns true' do
        expect(music_album.send(:can_be_archived?)).to eq(true)
      end
    end

    context 'when the album is not on Spotify' do
      let(:on_spotify) { false }

      it 'returns false' do
        expect(music_album.send(:can_be_archived?)).to eq(false)
      end
    end
  end
end
