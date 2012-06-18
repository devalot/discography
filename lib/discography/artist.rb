module Discography
  class Artist

    ############################################################################
    def initialize (file_name)
      @years  = {}
      load_discography_file(file_name)
    end

    ############################################################################
    # Return the first album released.
    def first_album
      first_year_albums = @years[@years.keys.first]
      first_year_albums.first
    end

    ############################################################################
    # Given a year, return the next year that an album was released.
    def find_release_year_after (year)
      # Check to see if the requested year is even valid.
      if !@years.has_key?(year)
        return first_album.year
      end

      all_years = @years.keys
      index_of_year = all_years.index(year)

      if index_of_year == (all_years.size - 1)
        # The year given is the last year, wrap around to the first
        # year and return that.
        return first_album.year
      end

      all_years[index_of_year + 1]
    end

    ############################################################################
    # Return an array of all albums ever released.
    def albums
      @years.values.flatten
    end

    ############################################################################
    # Return an array of all the albums released in the given year.
    def albums_for_year (year)
      if @years.has_key?(year)
        @years[year]
      else
        []
      end
    end

    ############################################################################
    private

    ############################################################################
    def load_discography_file (file_name)
      discography = YAML.load_file(file_name)

      discography.each do |year, titles|
        @years[year] = titles.map {|title| Album.new(year, title)}
      end
    end
  end
end
