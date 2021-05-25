require "json"

class Crud 
  def initialize
    @file_path = "../data/movies.json"
    @films_to_watch = []
    load_data_from_json()
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

  # json file loaded with this method
  def load_data_from_json
    data = JSON.parse(File.read("../data/movies.json"))
    # transforms array
    @films_to_watch = data.map do |movie|
        movie.transform_keys(&:to_sym)
  end

  # responsible for opening and writing json
  rescue Errno::ENOENT
    File.open(@file_path, 'w+')
    File.write(@file_path, [])
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


  def delete_film_on_list(movie_title)
    @films_to_watch.delete(movie_title)
          
    # Saves what's left to json
    save_data_to_json()
  end

  def update(title, year, tag, newData)
    newMovieObj = search_movie_with_year(title, year)

    # Delete the old movie with old data
    delete(title, year)

    # Overwrite the old data
    newMovieObj[tag.to_sym] = newData

    # Save -  it will hard save in this method
    save(newMovieObj)
  end

end
