# Gems
require "artii"
require "tty-prompt"

# Local
require_relative "crud_class"
require_relative "case_statements"
require_relative "ascii_art"
require_relative "reviews"

class Welcome
  def initialize
    @prompt = TTY::Prompt.new
    @crud = Crud.new
    @conditionals = Conditionals.new
    @art = Art.new
    # @review = Review.new
  end


  def start_menu
    loop do
      @art.welcome_menu
      choices = [
      {name: "View movie list", value: 1},
      {name: "Add a movie to the list", value: 2},
      {name: "Select a random movie from the list", value: 3},
      {name: "Remove a movie from the list", value: 4},
      {name: "Add a movie review", value: 5},
      {name: "Quit", value: 6}
      ]
      input = @prompt.select("Please choose an option:", choices, cycle: true)
      menu(input)
    end
  end

  def menu(input)
    case input
    when 1
     @conditionals.view_movie_list
    when 2
      @conditionals.case_add_film
    when 3
      @conditionals.random
    when 4
      system "clear"
      delete_film = @crud.get_films()
      pp delete_film
      # @art.what_to_delete
      # choose = delete_film, ["Go back"]
      # @prompt.select("   ", choose, cycle: true)
      # if @prompt.yes?("Are you sure you want to delete this movie?")
      #   @crud.delete_film_on_list(choose)
      #   puts "Movie is removed"
      # else 
      #   start_menu
      # end
    when 5
      # @review
    when 6
      @conditionals.leave_app
    end
  end

end
