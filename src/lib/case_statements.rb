require_relative "crud_class"
require_relative "ascii_art"
require "artii"
require "terminal-table"
require "tty-reader"
require 'progress_bar'

class Conditionals
  def initialize
    @prompt = TTY::Prompt.new
    @crud = Crud.new
    @art = Art.new
    @big_font = Artii::Base.new :font => 'slant'
    @bar = ProgressBar.new(:bar, :percentage)
  end

  def movies_list
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

  def view_movie_list
    system "clear"
    if @crud.get_films.size == 0
      @art.no_movie
      if @prompt.yes? ("Would you like to add a movie to the list?")
        case_add_film
      else
        system "clear"
        Welcome.new.start_menu
      end

    else 
      movies_list
      puts "Press any key to go back to main menu"
      menu = gets.chomp
      system "clear"
    end
  end
  
  def case_add_film
    system "clear"
    @art.movie_to_add
      print "          > "

    film = {}
    film_name = gets.chomp

    @crud.add_film_to_list(film_name)
    film[:moviename] = film_name
    
    system "clear"
    @art.who_suggested_it
    print "          > "
    suggestion_name = gets.chomp
    puts ""
    puts "#{film_name} has been added by #{suggestion_name}"
    @crud.add_film_to_list(suggestion_name)
    film[:suggestedby] = suggestion_name
    @crud.save(film)
    sleep 2
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
      sleep 1.5
      system "clear"
    else
      system "clear"
      @art.random_film_to_watch
      sleep 1.5

      random_movie = @crud.get_films()
      puts "    The random movie is: #{random_movie.sample[:moviename]}"
      puts "================================"
      puts "Would you like to generate another random movie?"
      if @prompt.yes? ("Y: randomly generate a new movie/N: go back to menu")
        random
      else
        system "clear"
        Welcome.new.start_menu
      end
    end
  end

  def delete_movie_on_watch_list
    system "clear"
    if @crud.get_films.size == 0
      @art.no_movie
      sleep 1
      system "clear"
      Welcome.new.start_menu
    else
      movies_list
      input = @prompt.ask(' Enter movie to delete from list:', required: true).downcase
      if @crud.get_films.any? { |movie| movie[:moviename].downcase == input}
        puts ''
        seleted_movie = @crud.get_films.find { |movie| movie[:moviename].downcase == input}
        if @prompt.yes?("Do you want to delete #{seleted_movie[:moviename]}")
          @crud.get_films.delete(seleted_movie)
          @crud.save_data_to_json
          # system "clear"
          puts "Movie deleted from watch list"
          if @prompt.yes?("Would you like to select another movie to delete?}")
            delete_movie_on_watch_list
          else
            system "clear"
            Welcome.new.start_menu
          end
        # else
        #   delete_movie_on_watch_list
        end
      elsif @crud.get_films.size == 0
        @art.no_movie
      else
        puts 'Movie is not on the watch list.'
        if @prompt.yes?('Would you like to select a movie to delete')
          delete_movie_on_watch_list
        else
          Welcome.new.start_menu
        end
      end
    end
    sleep 1.5
  end
end