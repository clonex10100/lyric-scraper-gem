class Song
  attr_accessor :title, :artist, :views, :url, :chart_pos, :lyrics

  @@all = []

  def initialize(attributes)
    add_atributes(attributes)
    @@all << self
  end

  def self.create_from_array(array)
    array.each { |attributes| Song.new(attributes) }
  end

  def self.all
    @@all
  end

  def self.find_by_title(title)
    self.all.find { |song| song.title == title }
  end

  def self.find_by_chart_pos(pos)
    self.top_charts.find { |song| song.chart_pos == pos }
  end

  def add_atributes(attributes)
    attributes.each { |key, val| self.send("#{key}=", val) }
  end

  def display_lyrics
    if lyrics
      puts lyrics
    else
      puts "No lyrics for song"
    end
  end

  def display(i = 0)
    puts "#{i}." if i
    puts "Title: #{title}"
    puts "artist: #{artist}"
    puts "views: #{views}"
  end

  def self.top_charts
    self.all.select { |song| song.chart_pos }.sort_by { |song| song.chart_pos }
  end

  def self.display_top_charts
    top_charts.each.with_index(1) do |song, i|
      song.display(i)
      puts ""
    end
  end

  def self.display_songs
    all.each.with_index(1) do |song, i|
      song.display(i)
      puts ""
    end
  end
end
