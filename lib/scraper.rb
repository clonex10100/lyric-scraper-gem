class Scraper
  def self.scrape_top_charts(url)
    doc = open_url(url)
    top_songs = doc.css("#top-songs div div.icYXUj a")
    top_songs.map.with_index(1) do |song, position|
      {
        title:  song.css("div.ChartSongdesktop__CoverAndTitle-sc-18658hh-0 h3 div.ChartSongdesktop__Title-sc-18658hh-3").text,
        artist:  song.css("h4.ChartSongdesktop__Artist-sc-18658hh-5").text,
        views:  song.css("span.iRdQjQ").text,
        url:  song.attribute("href").value,
        chart_pos: position
      }
    end
  end

  def self.scrape_lyrics(url)
    doc = open_url(url)
    doc.css("div.lyrics p").text
  end

  def self.scrape_song_page(url)
    url = open(url)
    sleep 1
    doc = Nokogiri::HTML(url)
    song_hash = { 
      title: doc.css("div.header_with_cover_art-primary_info h1").text.strip,
      artist: doc.css("div.header_with_cover_art-primary_info h2").text.strip,
      views: doc.css("span.header_with_cover_art-primary_info").text.strip,
      url: url,
      lyrics: doc.css("div.lyrics p").text,
    }
    binding.pry
  end

  def self.open_url(url)
    Nokogiri::HTML(open(url))
  end
end
