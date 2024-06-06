module Movies
  class Query
    def self.get_movies(page, actor = nil)
      movies = Movie.joins(:reviews).select('movies.movie, movies.description, movies.year, movies.director, movies.actors, movies.filming_locations, movies.countries, AVG(reviews.stars) as average_rating').group(:id).order("average_rating desc").paginate(page: page)
      actor.blank? ? movies : movies.where("? = ANY(movies.actors)", actor)
    end

    def self.get_movies_api(actor = nil)
      movies = Movie.includes(:reviews).order(id: :asc)
      actor.blank? ? movies : movies.where("? = ANY(movies.actors)", actor)
    end
  end
end