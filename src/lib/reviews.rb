class Review
  def initialize
    @prompt = TTY::Prompt.new
    @art = Art.new
    @crud = Crud.new
  end
 

  def review_menu
  loop do
    system "clear"
    @art.review_movies
    choices = [
      {name: "   Add a movie review", value: 1},
      {name: "   Read a review", value: 2},
      {name: "   Delete a review", value: 3},
      {name: "   Go back", value: 4}]
      input = @prompt.select("   Please choose an option:", choices, cycle: true)
      menu(input)
    end
  end

  def menu(input)
    case input
    when 1
      add_review
    when 2
      # @conditionals.case_add_film
    when 3
      # @conditionals.random
    when 4
      Welcome.new.start_menu
    end
  end

  def add_review
    system "clear"
    @art.enter_movie_review
    movie_review = {}
    title_of_film = @prompt.ask("         > ", required: true)
    movie_review[:nameofmovie] = title_of_film
    @crud.add_review_to_list(title_of_film)
    system "clear"

    @art.reviewer_name
    review_name = @prompt.ask("         > ", required: true)
    movie_review[:person_reviewing] = review_name
    @crud.add_review_to_list(review_name)
    system "clear"

    @art.review_time
    movie_length = @prompt.ask("         > ", convert: :int)
    movie_review[:movie_time] = movie_length
    @crud.add_review_to_list(movie_length)
    system "clear"

    @art.review_rate
    rating = @prompt.select(" ") do |stars| 
      stars.choice "              ⭑⭑⭑⭑⭑"
      stars.choice "              ⭑⭑⭑⭑"
      stars.choice "              ⭑⭑⭑"
      stars.choice "              ⭑⭑"
      stars.choice "              ⭑"
      stars.choice "              TBD"
    end
    movie_review[:star_rating] = rating
    @crud.add_review_to_list(rating)
    system "clear"


    @art.review_comment
    comment = @prompt.ask("         > ")
    puts "    ================================="
    puts "    #{title_of_film} has been added to reviews"
    movie_review[:critique] = comment
    @crud.add_review_to_list(comment)

    @crud.review_save(movie_review)
    sleep 1.5
    review_menu
  end

    # input_metadata = @prompt.collect do
    #   key(:movie_title).ask("What movie are you reviewing?")
    #   key(:review_by).ask("Who?", required: true)
    #   key(:time).ask("Time?", convert: :int)
    #   key(:rating).select("What do you rate it?", %w(⭑⭑⭑⭑⭑ ⭑⭑⭑⭑ ⭑⭑⭑ ⭑⭑ ⭑ TBD))
    #   @art.review_comment
    #   key(:review)
    # end
    # review = {}
    # review[:movie_title] = input_review
    # review = input_metadata.merge(movie)
    # @crud << movie
    # save_data
    # system 'clear'
    # review_menu

  # end
end

