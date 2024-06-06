require 'test_helper'

class CsvImportTest < ActiveSupport::TestCase
  test "import movies and reviews csv files with all valid records" do
    Movies::CsvImporter.run("#{Rails.root}/test/fixtures/files/valid_csv", false)
    movie1 = Movie.find_by(movie: 'Gone in 60 seconds')
    movie2 = Movie.find_by(movie: 'Inception')
    assert !movie1.blank?
    assert !movie2.blank?
    assert movie1.reviews.count == 5
    assert movie2.reviews.count == 4
  end

  test "import movies and reviews csv files with some invalid records" do
    Movies::CsvImporter.run("#{Rails.root}/test/fixtures/files/invalid_csv", false)
    movie1 = Movie.find_by(movie: 'Gone in 60 seconds')
    movie2 = Movie.find_by(movie: 'Inception')
    assert !movie1.blank?
    assert movie2.blank?
    assert movie1.reviews.count == 4
  end
end