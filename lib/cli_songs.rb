class CliInterface
  def run
    @top_charts = nil
    help
    choice = nil
    while(!choice || choice != "exit")
      print "Please enter a command:"
      choice = gets.strip.downcase
      case choice
        when "top"
          top_charts
        when "song info"
          song_info
        when "help"
          help
        when "exit"
          puts "Goodbye"
        else
          puts "Invalid commant"
      end
    end
  end

  def top_charts
    SongImporter.import_top_charts if Song.top_charts.length == 0
    Song.display_top_charts
  end

  def top_lyric
    SongImporter.import_top_charts if Song.top_charts.length == 0
    print "please enter the number or title of the song you would like to see the lyric's for: "
    input = gets.strip
    if input.match(/\D/)
      #Input was a song name
      song = Song.find_by_title(input)
    else
      #Input was a song number
      input = input.to_i
      if input.between?(1,10)
        song = Song.find_by_chart_pos(input)
      else
        puts "Invalid song number"
      end
    end
    #Ensure song exists
    if !song
      puts "Sorry, song not found"
    else
      #Ensure song has lyrics, if not import them
      SongImporter.import_lyrics(song) if !song.lyrics
      song.display_lyrics
    end
  end

  def lyrics
    print "Please enter the song title: "
    title = gets.strip
    print "Please enter the song artist: "
    artist = gets.strip
  end

  def song_info
    print ("Please enter song title EXACTLY: ")
    title = gets.strip
    print ("Please enter song artist EXACTLY: ")
    artist = gets.strip
    SongImporter.import_song(title, artist)
  end

  def help
    puts "---Commands---"
    puts "\"top\" lists the current top 10 songs"
    puts "\"top lyrics\" to easily view lyrics for the top 10 songs"
    puts "\"lyrics search\" pull lyrics from a song"
    puts "\"help\" displays this list again"
  end

end
