require('test/unit')
require('discography')

class ArtistTest < Test::Unit::TestCase

  def setup
    file_name =
      File.expand_path('test_data.yml', File.dirname(__FILE__))

    @artist = Discography::Artist.new(file_name)
  end

  def test_first_album
    album = @artist.first_album
    assert(album, "album shouldn't be nil")
    assert_equal(1970, album.year)
    assert_equal("Plaid Pants United", album.title)
  end

  def test_albums_returns_correct_list
    albums = @artist.albums
    assert_kind_of(Array, albums)
    assert_equal(6, albums.size)
    assert_equal("Plaid Pants United", albums.first.title)
    assert_equal("Parachute Pants Forever", albums[2].title)
    assert_equal("Whose Pants Are These?", albums.last.title)
  end
end
