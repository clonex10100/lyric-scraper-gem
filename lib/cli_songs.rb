class CliInterface
  URL = "https://genius.com"
  def run
    make_song_list
    Song.display_songs
  end

  def make_song_list
    song_array = Scraper.scrape_top_charts(URL)
    Song.create_from_array(song_array)
  end

end
