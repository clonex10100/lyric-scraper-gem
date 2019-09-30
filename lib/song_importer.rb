#Uses Scraper to scrape pages and creates song objects
class SongImporter
  URL = "https://genius.com"

  def self.import_top_charts
    song_array = Scraper.scrape_top_charts(URL)
    Song.create_from_array(song_array)
  end

  def self.import_lyrics(song)
    song.lyrics = Scraper.scrape_lyrics(song.url)
  end

  def self.import_song(title, artist)
    artist = artist.gsub(" ", "-")
    title = title.gsub(" ", "-")
    Scraper.scrape_song_page("#{URL}/#{artist}-#{title}-lyrics")
  end
end
