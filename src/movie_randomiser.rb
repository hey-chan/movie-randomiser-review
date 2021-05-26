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
  puts " - View list: ./movieapp.sh -s list"
  puts " - Add to list: ./movieapp.sh -s add"
  puts " - A random movie: ./movieapp.sh -s random"
  puts " - Delete from list: ./movieapp.sh -s delete"
  puts " - Go to movie reviews: ./movieapp.sh -s reviews"
  puts " "

when "-start", "-s"
  case command_argument[0]
  when "list"
    Conditionals.new.view_movie_list
  when "add"
    Conditionals.new.case_add_film
  when "random"
    Conditionals.new.random
  when "delete"
    Conditionals.new.delete_movie_on_watch_list
  when "reviews"
    Review.new.review_menu
  else
    puts "This is not available"
  end
else
  system "clear"
  welcome = Welcome.new
  welcome.start_menu
end

# require "json"

# class Crud 
#   def initialize
#     @file_path = "./data/movies.json"
#     @films_to_watch = []
#     load_data_from_json()
#     @review_path = "./data/reviews.json"
#     @review_list = []
#     load_review()
#   end 

#   # method pushes into array
#   def add_film_to_list(movie)
#     @films_to_watch << movie
#   end   

#   # updates json files
#   def save(movie)
#     # Add to the temp local array.
#     load_data_from_json()
#     add_film_to_list(movie)
#     save_data_to_json()
#   end
  
#   # reviews
#   def add_review_to_list(review)
#     @review_list << review
#   end   
  
#   def review_save(review)
#     load_review()
#     add_review_to_list()
#     save_review
#   end
  

#   # json file loaded with this method
#   def load_data_from_json
#     data = JSON.parse(File.read("./data/movies.json"))
#     # transforms array
#     @films_to_watch = data.map do |movie|
#         movie.transform_keys(&:to_sym)
#   end

#   # review
#   def load_review
#     data = JSON.parse(File.read("./data/reviews.json"))
#     # transforms array
#     @review_list = data.map do |review|
#         review.transform_keys(&:to_sym)
#   end

#   # responsible for opening and writing json
#   rescue Errno::ENOENT
#     File.open(@file_path, 'w+')
#     File.write(@file_path, [])
#     File.open(@review_list, 'w+')
#     File.write(@review_list, [])
#     retry
#   end
  
#   # responsible for loading json file
#   def get_films
#     load_data_from_json()
#     return @films_to_watch
#   end

#   def save_data_to_json()
#     File.write(@file_path, @films_to_watch.to_json)
#   end
  
#   def clear_data()
#     File.open(@file_path, 'w') {|file| file.truncate(0) }
#   end
  

#   # review
#   def save_review()
#     File.write(@review_path , @review_list.to_json)
#   end
  
#   def get_review
#     load_review()
#     return @review_list
#   end
# end
