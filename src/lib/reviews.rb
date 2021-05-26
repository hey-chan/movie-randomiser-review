class Review
  def initialize
    @prompt = TTY::Prompt.new
    @art = Art.new
  end
 

  def review_menu
    system "clear"
    @art.review_movies
    selection = @prompt.select("Please choose an option:", cycle: true) do |menu|
      menu.choice "Add a movie review",  value: 1
      menu.choice "Update a review", value: 2
      menu.choice "Delete review",  value: 3
      menu.choice "Go back", value: 4
    end
    selection_process(selection)
  end

  def selection_process(decide)
    case decide
    when 1
      # @conditionals.view_movie_list
    when 2
      # @conditionals.case_add_film
    when 3
      # @conditionals.random
    when 4
      Welcome.new.start_menu
    end
  end

end


