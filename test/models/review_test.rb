require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.create(movie: 'First Movie', description: 'This is movie 1', year: '2013', director: 'Person A', actors: ['Person B', 'Person C'], filming_locations: ['Kuala Lumpur', 'Singapore'], countries: ['MY', 'SG'])
  end

  test "valid review" do
    review = Review.new(movie_id: @movie.id, user: 'User A', stars: 4, review: 'Awesome!')
    assert review.valid?
  end

  test "invalid without user" do
    review = Review.new(movie_id: @movie.id, stars: 4, review: 'Awesome!')
    refute review.valid?, 'review is valid without user'
    assert_not_nil review.errors[:user], 'no validation error for user present'
  end

  test "invalid without stars" do
    review = Review.new(movie_id: @movie.id, user: 'User A', review: 'Awesome!')
    refute review.valid?, 'review is valid without stars'
    assert_not_nil review.errors[:stars], 'no validation error for stars present'
  end

  test "invalid without review text" do
    review = Review.new(movie_id: @movie.id, user: 'User A', stars: 4)
    refute review.valid?, 'review is valid without review text'
    assert_not_nil review.errors[:review], 'no validation error for review text present'
  end
end
