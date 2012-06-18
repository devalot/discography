module Discography
  class Album

    ############################################################################
    # Expose @year and @title for reading and writing.
    attr_accessor(:year, :title)

    ############################################################################
    def initialize (year, title)
      @year  = year
      @title = title
    end
  end
end
