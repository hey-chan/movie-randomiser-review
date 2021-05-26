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
      {name: "   Read and update a review", value: 2},
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
      review_list
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

  def review_list
    system "clear"
    if @crud.get_review.size == 0
      @art.no_movie
      if @prompt.yes? ("Would you like to add a review to the list?")
        add_review
      else
        review_menu
      end

    else
    people_reviews = @crud.get_review()
    table = Terminal::Table.new :title => "Movies that have been reviewed" do |t|
      t << [Rainbow('Movie:').greenyellow, Rainbow('Reviewed by:').royalblue] 
      people_reviews.each do |item|
        t.add_separator 
        t.style = { :border => :unicode_thick_edge }
        t << [(item[:nameofmovie]), (item[:person_reviewing])]
      end
    end
    puts table
    input = @prompt.select("Please select an option", cycle: true) do |menu|
      menu.choice "    Select a review to read", 1
      menu.choice "    Update a review", 2
      menu.choice "    Go back", 3
    end
    case input
    when 1
      
    when 2

    when 3
      review_menu
    end
  end


  end

end

