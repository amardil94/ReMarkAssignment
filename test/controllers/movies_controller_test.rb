require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movies_url
    assert_response :success
    assert_select "h1", "List of movies"
  end
end
