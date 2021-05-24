require "json"

class Crud 
    def initialize
        @file_path = "../data/movies.json"
        @movies = []
        load_data()
    end 

    def save(movie)
        # Add to the temp local array.
        load_data()
        add_movie(movie)
        save_data()
    end

    def load_data
        # puts "Data loaded"
        data = JSON.parse(File.read("../data/movies.json"))
        # puts data
        @movies = data.map do |movie|
            movie.transform_keys(&:to_sym)
    end

    rescue Errno::ENOENT
        File.open(@file_path, 'w+')
        File.write(@file_path, [])
        retry
    end
    
    def save_data()
        File.write(@file_path, @movies.to_json)
    end

    def clear_data()
        File.open(@file_path, 'w') {|file| file.truncate(0) }
    end
    
    def add_movie(movie)
        @movies << movie
    end    

    def get_films
        load_data()
        return @movies
    end

    def delete(movieTitle, year)
        @movies.delete_if { |movieObj| 
            movieObj[:title] == movieTitle && movieObj[:year] == year }
        # Save the data
        save_data()
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