require "test_helper"

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    movie1 = Movie.create(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    movie2 = Movie.create(movie: 'Second Movie', description: 'This is movie 2', year: '2016', director: 'Person D', actors: ['Person E', 'Person F'], filming_locations: ['Jakarta', 'Bangkok'], countries: ['ID', 'TH'])
    Review.create(movie_id: movie1.id, user: 'User A', stars: 4, review: 'Awesome!')
    Review.create(movie_id: movie1.id, user: 'User B', stars: 2, review: 'Meh')
    Review.create(movie_id: movie1.id, user: 'User E', stars: 1, review: 'Bad')
    Review.create(movie_id: movie2.id, user: 'User C', stars: 5, review: 'Amazing!')
    Review.create(movie_id: movie2.id, user: 'User D', stars: 3, review: 'Pretty average')
  end

  test "get movie data" do
    get '/api/v1/movies'
    assert_response :success
    movies = @response.parsed_body
    assert movies.length == 2
    assert movies.first['movie'] == 'First Movie'
    assert movies.first['reviews'].length == 3
    assert movies.second['movie'] == 'Second Movie'
    assert movies.second['reviews'].length == 2
  end
end
