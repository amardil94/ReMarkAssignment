require 'test_helper'

class QueryTest < ActiveSupport::TestCase
  def setup
    movie1 = Movie.create(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    movie2 = Movie.create(movie: 'Second Movie', description: 'This is movie 2', year: '2016', director: 'Person D', actors: ['Person E', 'Person F'], filming_locations: ['Jakarta', 'Bangkok'], countries: ['ID', 'TH'])
    Review.create(movie_id: movie1.id, user: 'User A', stars: 4, review: 'Awesome!')
    Review.create(movie_id: movie1.id, user: 'User B', stars: 2, review: 'Meh')
    Review.create(movie_id: movie2.id, user: 'User C', stars: 5, review: 'Amazing!')
    Review.create(movie_id: movie2.id, user: 'User D', stars: 3, review: 'Pretty average')
  end

  test "query movies without actor filter" do
    movies = Movies::Query.get_movies(1)
    assert movies.length == 2
    assert movies.first.movie == 'Second Movie'
    assert movies.first.average_rating == 4
    assert movies.second.movie == 'First Movie'
    assert movies.second.average_rating == 3
  end

  test "query movies with actor filter" do
    movies = Movies::Query.get_movies(1, 'Person B')
    assert movies.length == 1
    assert movies.first.movie == 'First Movie'
  end

  test "query movies with pagination of one movie per page" do
    Movie.per_page = 1
    movies = Movies::Query.get_movies(1)
    Movie.per_page = 10
    assert movies.length == 1
    assert movies.first.movie == 'Second Movie'
  end

  test "query movies for api without actor" do
    movies = Movies::Query.get_movies_api
    assert movies.length == 2
    assert movies.first.movie == 'First Movie'
    assert movies.second.movie == 'Second Movie'
  end

  test "query movies for api with actor" do
    movies = Movies::Query.get_movies_api('Person E')
    assert movies.length == 1
    assert movies.first.movie == 'Second Movie'
  end
end