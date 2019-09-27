class Song
  attr_accessor :title, :artist, :views, :url

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

  def add_atributes(attributes)
    attributes.each { |key, val| self.send("#{key}=", val) }
  end

  def display(i = 0)
    puts "#{i}." if i
    puts "Title: #{title}"
    puts "artist: #{artist}"
    puts "views: #{views}"
  end

  def self.display_songs
    all.each.with_index(1) do |song, i|
      song.display(i)
      puts ""
    end
  end
end
