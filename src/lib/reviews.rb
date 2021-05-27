class Review
  def initialize
    @prompt = TTY::Prompt.new
    @art = Art.new
    @crud = Crud.new
    # @movie_review = {}
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
      review_list_choices
    when 3
      delete_review
    when 4
      Welcome.new.start_menu
    end
  end

  # case 1 of review_menu
  def add_review
    system "clear"
    input_metadata = @prompt.collect do
      system "clear"
      key(:nameofmovie).ask("#{Art.new.enter_movie_review}         > ", required: true)
      system "clear"
      key(:person_reviewing).ask("#{Art.new.reviewer_name}         > ", required: true)
      system "clear"
      key(:movie_time).ask("#{Art.new.review_time}         > ", convert: :int)
      system "clear"
      key(:rating).select("#{Art.new.review_rate}", %w(⭑⭑⭑⭑⭑ ⭑⭑⭑⭑ ⭑⭑⭑ ⭑⭑ ⭑ TBD))
      system "clear"
      key(:critique).ask("#{Art.new.review_comment}          >")
    end
    # if 
    #   @crud.get_review(:nameofmovie) == @crud.get_review(:nameofmovie)
    # else
      puts "   #{Rainbow(input_metadata[:nameofmovie]).darkgreen} has been added to reviews"
      movie_review = {}
      movie_review = input_metadata.merge(movie_review)
      @crud.review_save(movie_review)
      sleep 1.5
      review_menu
    # end
  end

  # applicable for case 2 (review) and case 3 (delete)
  def movie_reviews_table
    people_reviews = @crud.get_review()
    table = Terminal::Table.new :title => "#{Rainbow(@art.cinema_review).indianred}" do |t|
      t << [Rainbow('Movie:').greenyellow, Rainbow('Reviewed by:').royalblue] 
      people_reviews.each do |item|
        t.add_separator 
        t.style = { :border => :unicode_thick_edge }
        t << [(item[:nameofmovie]), (item[:person_reviewing])]
      end
    end
    puts table
  end

  # case 2 of review_menu (review and select)
  def review_list_choices
    system "clear"
    if @crud.get_review.size == 0
      @art.no_movie
      if @prompt.yes? ("Would you like to add a review to the list?")
        add_review
      else
        review_menu
      end

    else
      movie_reviews_table
      input = @prompt.select("  Please select an option", cycle: true) do |menu|
      puts ""
      menu.choice "    Select a review to read", 1
      menu.choice "    Go back", 2
    end

    case input
    when 1
      reads_review
    when 2
      review_menu
    end
    end
  end

  # part of case 2 of review_menu
  def reads_review
    system "clear"
    movie_reviews_table
    read_a_review = @prompt.ask("  What review would you like to read?", required: true).downcase
    if @crud.get_review.any? { |review| review[:nameofmovie].downcase == read_a_review}
      puts ''
      selected_review = @crud.get_review.find { |review| review[:nameofmovie].downcase == read_a_review}
      system 'clear'
      display_review(selected_review)

    else
      puts "  Cannot find a review of #{read_a_review} "
      puts " "
      if @prompt.yes?("  Would you like to select a different review?")
        reads_review
      else
        movie_reviews_table
      end
    end
  end

  def display_review(selected_review)
    table = Terminal::Table.new :title => "#{Rainbow(selected_review[:nameofmovie]).magenta}" do |t|
      t << [Rainbow("Reviewed by").wheat, Rainbow(selected_review[:person_reviewing]).cornflower]
      t << [Rainbow("Movie length").wheat, Rainbow(selected_review[:movie_time]).cornflower]
      t << [Rainbow("Star rating").wheat, Rainbow(selected_review[:star_rating]).cornflower]
      t << [Rainbow("Comments/reviews").wheat, Rainbow(selected_review[:critique]).cornflower]
      t.style = {:all_separators => true}
      t.style = { :border => :unicode_thick_edge }
    end
    puts table
    
    if @prompt.yes?("  Would you like to read another review?")
      reads_review # Repeats function
    else
      review_menu
    end
  end

  # case 3 of review_menu
  def delete_review
    system "clear"
    if @crud.get_review.size == 0
      @art.no_movie
      sleep 1
      review_menu
    else
      movie_reviews_table
      input = @prompt.ask("  Enter a movie review you want to delete:", required: true).downcase
      if @crud.get_review.any? { |reviews| reviews[:nameofmovie].downcase == input}
        puts ''
        selected_review = @crud.get_review.find { |reviews| reviews[:nameofmovie].downcase == input}
        if @prompt.yes?("  Do you want to delete #{Rainbow(selected_review[:nameofmovie]).aquamarine}")
          @crud.get_review.delete(selected_review)
          @crud.save_review_json
          puts "  ========================================"
          puts "  #{Rainbow(selected_review[:nameofmovie]).red} has been deleted from watch list"

          if @prompt.yes?("  Would you like to select another review to delete?}")
            delete_review
          else
            review_menu
          end
        else
          delete_review
        end
      elsif @crud.get_review.size == 0
        @art.no_movie
      else
        puts " "
        puts "  #{Rainbow(input).mediumvioletred} is not on the watch list."
        puts "  ========================================"
        if @prompt.yes?("  Would you like to select a movie to delete?")
          delete_review # Repeats function
        else
          review_menu
        end
      end
    end
    sleep 1.5
  end
end

