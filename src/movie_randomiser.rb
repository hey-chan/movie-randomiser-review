require_relative "lib/main.rb"

# Has access
first_argument, *command_argument = ARGV
ARGV.clear
case first_argument
when "-help" 
  puts " "
  puts 'Welcome to the Movie Randomiser and Review app!'
  puts "This application is designed for movie lovers who:"
  puts "1. Want to add movie to a watch list"
  puts "2. Want a randomly generated movie from that watch list without the indecision involved"
  puts "3. Add a review for a particular movie"
  puts " "
  puts "To run this app, use either:"
  puts "  ruby movie_randomiser.rb"
  puts "      or"
  puts "  ./movieapp.sh"
  puts " "
  puts "To access the different app features with the command line arguments"
  puts " - View list: ./movieapp.sh -s viewlist"
  puts " - Add to list: ./movieapp.sh -s add"
  puts " - Delete from list: ./movieapp.sh -s delete"
  puts " - Go to movie reviews: ./movieapp.sh -s reviews"
  puts " "

when "-start", "-s"
  case command_argument[0]
  when "viewlist"
    Conditionals.new.view_movie_list
  when "add"
    Conditionals.new.case_add_film
  when "delete"
    Conditionals.new.delete_movie_on_watch_list
  # when " "
  #   Reviews.new.misc
  else
    puts "This is not available"
  end
else
  system "clear"
  welcome = Welcome.new
  welcome.start_menu
end