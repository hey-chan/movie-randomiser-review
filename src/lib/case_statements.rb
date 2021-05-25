require_relative "crud_class"
require_relative "ascii_art"
require "artii"
require "terminal-table"
require "tty-reader"

class Conditionals
  def initialize
    @prompt = TTY::Prompt.new
    @crud = Crud.new
    @art = Art.new
    @big_font = Artii::Base.new :font => 'slant'
    @reader = TTY::Reader.new
    
  end
  def view_movie_list
    system "clear"
    if @crud.get_films.size == 0
      @art.no_movie
      if @prompt.yes? ("Would you like to add a movie to the list?")
        case_add_film
      end

    else 
      movies = @crud.get_films()
      table = Terminal::Table.new :title => "#{@art.watch_movie}" do |t|
        t << [('Movie:'), ('Suggested by:')] 
        movies.each do |item|
          t.add_separator 
          t.style = { :border => :unicode_thick_edge }
          t << [(item[:moviename]), (item[:suggestedby])]
        end
      end
      puts table
    end
    puts "Press any key to go back to main menu"
    menu = gets.chomp
    system "clear"
  end
  
  def case_add_film
    system "clear"
    @art.movie_to_add
      print "            > "

    film = {}
    film_name = gets.chomp.capitalize

    @crud.add_film_to_list(film_name)
    film[:moviename] = film_name
    
    system "clear"
    @art.who_suggested_it
    print "            > "
    suggestion_name = gets.chomp.capitalize
    puts ""
    puts "#{film_name} has been added by #{suggestion_name}"
    @crud.add_film_to_list(suggestion_name)
    film[:suggestedby] = suggestion_name
    @crud.save(film)
    system "clear"
  end

  def leave_app
    puts @big_font.asciify('Good bye')
    puts "          Thanks for using this app"
    puts "               © Matthew Liu"
    exit
  end

  def random
    if @crud.get_films.size == 0
      system "clear"
      @art.no_movie
    else
      system "clear"
      @art.random_film_to_watch
      sleep(1.5)
      random_movie = @crud.get_films()
      puts "The random movie is: #{random_movie.sample[:moviename]}"
    end
  end

end