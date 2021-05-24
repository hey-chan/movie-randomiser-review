# Gems
require "artii"
require "tty-prompt"

# Local
require_relative "crud_class"
require_relative "selection"

class Welcome
  def initialize
    @prompt = TTY::Prompt.new
    @crud = Crud.new
  end

  # films_to_watch = [{movie: "The Avengers", suggested: "Matthew"}]

  def start_menu
    loop do
      puts "
        _________________________________
        |                               |
        |                               |
        |      █▀▄▀█ █▀█ █░█ █ █▀▀      |
        |      █░▀░█ █▄█ ▀▄▀ █ ██▄      |
        |        Randomiser and         |
        |            Review             |
        |                               |
        '-------------------------------'
        
              (~~) (~~) (~~) (~~)
              _)(___)(___)(___)(_
            (~~) (~~) (~~) (~~) (~~)
            _)(___)(___)(___)(___)(_
        (~~) (~~) (~~) (~~) (~~) (~~)
        _)(___)(___)(___)(___)(___)(_
        |    |    |    |    |    |    |
        |    |    |    |    |    |    |
        ||~~~~~||~~~~~||~~~~~||~~~~~~|| 
        `'     `'     `'     `'      `'    
        "
      choices = [
        {name: "View movie list", value: 1},
      {name: "Add a movie to the list", value: 2},
      {name: "Select a random movie from the list", value: 3},
      {name: "Remove a task from the list", value: 4},
      {name: "Add a movie review", value: 5},
      {name: "Quit", value: 6}
      ]

      input = @prompt.select("Please choose an option:", choices, cycle: true)

      menu(input)
    end
    # art = Artii::Base.new :font => 'slant'
    # puts art.asciify('Welcome')
  end

  def menu(input)
    case input
    when 1
      system "clear"
      if @crud.get_films.size == 0
        puts "There is no movie on the list."
        if @prompt.yes? ("Would you like to add a movie to the list?")
          puts "Enter a movie to add to list"
          print "> "
          film = {}

          @crud.add_movie(film_name)
          film[:movie_name] = film_name
          film_name = gets.chomp
          
          
          puts "Who suggested this movie?"
          print "> "
          
          suggestion_name = gets.chomp
          puts "#{film_name} has been added by #{suggestion_name}"
          @crud.add_movie(suggestion_name)
          film[:suggestedby] = suggestion_name

          @crud.save(film)
          # @crud.save(film)
          # puts "#{film} has been added"
        # else
        #   menu(prompt)
        end
      else 
        system "clear"
        puts "View the movie list"
        movies = @crud.get_films()
        movies.each do |item|
        puts " • Movie name: #{item[:movie_name]}, Suggested by: #{item[:suggestedby]}"

      end
        # if prompt.yes? ("Would you like to add a movie to the list?")
        #   puts "Enter a movie to add to list"
        # end
    end
    when 2
      system "clear"
      puts "
        _________________________________
        |                               |
        |                               |
        |                               |
        | Enter a movie to add to list  |
        |                               |
        |                               |
        |                               |
        '-------------------------------'
        
              (~~) (~~) (~~) (~~)
              _)(___)(___)(___)(_
            (~~) (~~) (~~) (~~) (~~)
            _)(___)(___)(___)(___)(_
        (~~) (~~) (~~) (~~) (~~) (~~)
        _)(___)(___)(___)(___)(___)(_
        |    |    |    |    |    |    |
        |    |    |    |    |    |    |
        ||~~~~~||~~~~~||~~~~~||~~~~~~|| 
        `'     `'     `'     `'      `'    
        "
      film = {}
      print "            > "

      film_name = gets.chomp
      @crud.add_movie(film_name)
      film[:movie_name] = film_name
      
      system "clear"
      puts "
        _________________________________
        |                               |
        |                               |
        |                               |
        |   Who suggested this movie?   |
        |                               |
        |                               |
        |                               |
        '-------------------------------'
                 

              (~~) (~~) (~~) (~~)
              _)(___)(___)(___)(_
            (~~) (~~) (~~) (~~) (~~)
            _)(___)(___)(___)(___)(_
        (~~) (~~) (~~) (~~) (~~) (~~)
        _)(___)(___)(___)(___)(___)(_
        |    |    |    |    |    |    |
        |    |    |    |    |    |    |
        ||~~~~~||~~~~~||~~~~~||~~~~~~|| 
        `'     `'     `'     `'      `'    
        "
    
      print "            > "
      suggestion_name = gets.chomp
      puts
      puts "#{film_name} has been added by #{suggestion_name}"
      @crud.add_movie(suggestion_name)
      film[:suggestedby] = suggestion_name

      @crud.save(film)
    when 3
      system "clear"
      # cap_film = films_to_watch.split.map(&:capitalize).join(' ')
      # film_array = films_to_watch.map {|word| word.capitalize}
      # cap_film_string = film_array.join(" ")
      puts "Determining the movie to watch...."
      sleep(1.5)
      puts "The random movie is: #{films_to_watch.sample.capitalize}"
      # puts "The random movie is: #{cap_film}"
    when 4
      system "clear"
      # choose = films_to_watch, ["Cancel and go back"]
      #   @prompt.select("What movie do you want to delete?", choose, cycle: true)
      # # choose.delete_at(delete_film)
      # puts "film has been deleted"
    when 5
      puts "Add a movie review"
    when 6
      leave_app
    end
    # system "clear"
  end

end