# require_relative "crud_class"

# class Review
#   def initialize
#     @crud = Crud.new
#   end

  

# end

# system "clear"
# puts "Movies to watch"
# table = Terminal::Table.new do |t|
#   t << ['Movie', 'Suggested by'] 
#   movies = @crud.get_films()
#   movies.each do |item|
#     t.add_separator 
#     t.style = { :border => :unicode_thick_edge }
#     t << [(item[:moviename]), (item[:suggestedby])]
#   end
# end
# # puts " • Movie name: #{item[:moviename]}, Suggested by: #{item[:suggestedby]}"
# end