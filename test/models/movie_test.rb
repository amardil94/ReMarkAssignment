require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "valid movie" do
    movie = Movie.new(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    assert movie.valid?
  end

  test "invalid without movie name" do
    movie = Movie.new(description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    refute movie.valid?, 'movie is valid without movie name'
    assert_not_nil movie.errors[:movie], 'no validation error for movie name present'
  end

  test "invalid without description" do
    movie = Movie.new(movie: 'First Movie', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    refute movie.valid?, 'movie is valid without description'
    assert_not_nil movie.errors[:description], 'no validation error for description present'
  end

  test "invalid without year" do
    movie = Movie.new(movie: 'First Movie', description: 'This is movie 1', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    refute movie.valid?, 'movie is valid without year'
    assert_not_nil movie.errors[:year], 'no validation error for year present'
  end

  test "invalid without director" do
    movie = Movie.new(movie: 'First Movie', description: 'This is movie 1', year: '2013', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    refute movie.valid?, 'movie is valid without director'
    assert_not_nil movie.errors[:director], 'no validation error for director present'
  end

  test "invalid without actors" do
    movie = Movie.new(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
    refute movie.valid?, 'movie is valid without actors'
    assert_not_nil movie.errors[:actors], 'no validation error for actors present'
  end

  test "invalid without filming locations" do
    movie = Movie.new(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], countries: ['MY', 'SG'])
    refute movie.valid?, 'movie is valid without filming locations'
    assert_not_nil movie.errors[:filming_locations], 'no validation error for filming locations present'
  end

  test "invalid without countries" do
    movie = Movie.new(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'])
    refute movie.valid?, 'movie is valid without countries'
    assert_not_nil movie.errors[:countries], 'no validation error for countries present'
  end
end
