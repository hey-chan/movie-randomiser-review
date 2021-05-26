require "json"

class Crud 
  def initialize
    @file_path = "./data/movies.json"
    @films_to_watch = []
    load_data_from_json()
    @review_path = "./data/reviews.json"
    @review_list = []
    load_review()
  end 

  # method pushes into array
  def add_film_to_list(movie)
    @films_to_watch << movie
  end   

  # updates json files
  def save(movie)
    # Add to the temp local array.
    load_data_from_json()
    add_film_to_list(movie)
    save_data_to_json()
  end
  
  # reviews
  def add_review_to_list(review)
    @review_list << review
  end   
  
  def review_save(review)
    load_review()
    add_review_to_list(review)
    save_review_json
  end
  

  # json file loaded with this method
  def load_data_from_json
    data = JSON.parse(File.read("./data/movies.json"))
    # transforms array
    @films_to_watch = data.map do |movie|
        movie.transform_keys(&:to_sym)
  end

  # review
  def load_review
    data = JSON.parse(File.read("./data/reviews.json"))
    # transforms array
    @review_list = data.map do |review|
        review.transform_keys(&:to_sym)
  end

  # responsible for opening and writing json
  rescue Errno::ENOENT
    File.open(@file_path, 'w+')
    File.write(@file_path, [])
    retry
    File.open(@review_list, 'w+')
    File.write(@review_list, [])
    retry
  end
  
  # responsible for loading json file
  def get_films
    load_data_from_json()
    return @films_to_watch
  end

  def save_data_to_json()
    File.write(@file_path, @films_to_watch.to_json)
  end
  
  def clear_data()
    File.open(@file_path, 'w') {|file| file.truncate(0) }
  end
  

  # review
  def save_review_json()
    File.write(@review_path , @review_list.to_json)
  end

  def get_review
    load_review()
    return @review_list
  end
end
end
    

