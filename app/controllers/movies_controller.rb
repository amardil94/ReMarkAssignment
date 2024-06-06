class MoviesController < ApplicationController
  def index
    @movies = Movies::Query.get_movies(params[:page], params[:actor])
  end
end
