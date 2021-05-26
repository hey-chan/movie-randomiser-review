class Conditionals
  def initialize
    @prompt = TTY::Prompt.new
    @crud = Crud.new
    @art = Art.new
  end

 # applicable to case 1 and 4 if conditions > 0
  def movies_list
    movies = @crud.get_films()
    table = Terminal::Table.new :title => "#{Rainbow(@art.watch_movie).darkorange}" do |t|
      t << [Rainbow('Movie:').greenyellow, Rainbow('Suggested by:').royalblue] 
      movies.each do |item|
        t.add_separator 
        t.style = { :border => :unicode_thick_edge }
        t << [(item[:moviename]), (item[:suggestedby])]
      end
    end
    puts table
  end

  # case 1: view
  def view_movie_list
    system "clear"
    if @crud.get_films.size == 0
      @art.no_movie
      if @prompt.yes? ("Would you like to add a movie to the list?")
        case_add_film
      else
        Welcome.new.start_menu
      end

    else 
      movies_list
      puts "Press any key to go back to main menu"
      menu = gets.chomp
      Welcome.new.start_menu
    end
  end
  
  # case 2: add
  def case_add_film
    system "clear"
    @art.movie_to_add
    film = {}
    film_name =  @prompt.ask("         > ", required: true)
    # avoids duplicates, whether entirely upcase, downcase or mix of both
    if @crud.get_films.any? { |movie| movie[:moviename].downcase == film_name || movie[:moviename].upcase == film_name || movie[:moviename].capitalize == film_name }
      puts "    ================================="
      puts "    This movie is already in your watch list"
      if @prompt.yes?("    Would you like to add another movie to the watch list?")
        case_add_film
      else 
        Welcome.new.start_menu
      end
    else
      film[:moviename] = film_name
      @crud.add_film_to_list(film_name)
      system "clear"

      @art.who_suggested_it
      suggestion_name =  @prompt.ask("         > ", required: true)
      puts "    ================================="
      puts "    #{Rainbow(film_name).aquamarine} has been added by #{Rainbow(suggestion_name).lightblue}"

      @crud.add_film_to_list(suggestion_name)
      film[:suggestedby] = suggestion_name
      @crud.save(film)
      sleep 2
    end
    Welcome.new.start_menu
  end

  # case 3: generate random film through .sample
  def random
    if @crud.get_films.size == 0
      system "clear"
      @art.no_movie
      sleep 1.1
      Welcome.new.start_menu
    else
      system "clear"
      @art.random_film_to_watch
      sleep 1.5

      random_movie = @crud.get_films()
      puts "    The random movie is: #{Rainbow(random_movie.sample[:moviename]).plum}"
      puts "    ================================="
      puts "    Would you like to generate another random movie?"
      if @prompt.yes? ("    Y: randomly generate a new movie/N: go back to menu")
        random
      else
        Welcome.new.start_menu
      end
    end
    Welcome.new.start_menu
  end

  # case 4: delete film
  def delete_movie_on_watch_list
    system "clear"
    if @crud.get_films.size == 0
      @art.no_movie
      sleep 1
      Welcome.new.start_menu
    else
      movies_list
      input = @prompt.ask("  Enter movie to delete from watch list:", required: true).downcase
      if @crud.get_films.any? { |movie| movie[:moviename].downcase == input}
        puts ''
        seleted_movie = @crud.get_films.find { |movie| movie[:moviename].downcase == input}
        if @prompt.yes?("  Do you want to delete #{Rainbow(seleted_movie[:moviename]).aquamarine}")
          @crud.get_films.delete(seleted_movie)
          @crud.save_data_to_json
          puts "  ========================================"
          puts "  #{Rainbow(seleted_movie[:moviename]).red} has been deleted from watch list"
          if @prompt.yes?("  Would you like to select another movie to delete?}")
            delete_movie_on_watch_list
          else
            Welcome.new.start_menu
          end
        else
          delete_movie_on_watch_list # Repeats function
        end
      elsif @crud.get_films.size == 0
        @art.no_movie
      else
        puts " "
        puts "  #{Rainbow(input).mediumvioletred} is not on the watch list."
        puts "  ========================================"
        if @prompt.yes?("  Would you like to select a movie to delete?")
          delete_movie_on_watch_list # Repeats function
        else
          Welcome.new.start_menu
        end
      end
    end
    sleep 1.5
  end

  def leave_app
    system "clear"
    puts @art.closing_credit
    sleep 1
    exit
  end
end