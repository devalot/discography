#!/usr/bin/env ruby

################################################################################
$LOAD_PATH.unshift(File.expand_path("../lib", File.dirname(__FILE__)))

################################################################################
require("discography")

################################################################################
class UserInterface

  ##############################################################################
  BEASTIE_BOYS = File.expand_path("../config/beastie_boys.yml",
                                  File.dirname(__FILE__))

  ##############################################################################
  def initialize
    @artist = Discography::Artist.new(BEASTIE_BOYS)
    @last_year_entered = @artist.first_album.year
  end

  ##############################################################################
  def run
    loop do
      $stdout.write("Please enter a command: ")
      answer = $stdin.gets.chomp

      case answer
      when "quit"
        $stdout.puts("Goodbye.")
        exit

      when "albums"
        print_all_albums

      when /^\d+$/
        @last_year_entered = answer.to_i
        print_year(@last_year_entered)

      when "next"
        print_next_year(@last_year_entered)

      else
        $stdout.puts("Sorry, I didn't understand that command")
      end
    end
  end

  ##############################################################################
  private

  ##############################################################################
  def print_all_albums
    @artist.albums.each {|album| print_album(album)}
  end

  ##############################################################################
  def print_year (year)
    albums = @artist.albums_for_year(year)

    if albums.empty?
      $stdout.puts("No albums released in #{year}")
    else
      albums.each {|album| print_album(album)}
    end
  end

  ##############################################################################
  def print_album (album)
    $stdout.puts("#{album.title} (#{album.year})")
  end

  ##############################################################################
  def print_next_year (previous_year)
    @last_year_entered = @artist.find_release_year_after(previous_year)
    print_year(@last_year_entered)
  end
end

################################################################################
begin
  UserInterface.new.run
rescue RuntimeError => e
  $stderr.puts(File.basename($0) + ": ERROR: #{e}")
  exit(1)
end
