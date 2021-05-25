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
      {name: "View movies to watch", value: 1},
      {name: "Add a movie to the watch list", value: 2},
      {name: "Select a random movie from the watch list", value: 3},
      {name: "Remove a movie from the watch list", value: 4},
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
      @conditionals.delete_movie_on_watch_list
    when 5
      # @review
    when 6
      @conditionals.leave_app
    end
  end

end
