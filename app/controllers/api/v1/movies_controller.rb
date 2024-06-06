module Api
  module V1
    class MoviesController < ApplicationController
      def index
        @movies = Movies::Query.get_movies_api(params[:actor])
        render json: @movies, except: [:id, :created_at, :updated_at], include: [:reviews => { :except => [:id, :movie_id, :created_at, :updated_at] }]
      end
    end
  end
end