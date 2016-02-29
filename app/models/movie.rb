class Movie < ActiveRecord::Base
    
     def self.all_ratings
         @@all_ratings = []
         @movies = Movie.all
         @movies.each do |m|
             if @@all_ratings.include?(m.rating)==false
                 @@all_ratings.push(m.rating)
            end
        end
        return @@all_ratings
    end
    
            
    
end
