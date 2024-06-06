class Movie < ApplicationRecord
  has_many :reviews
  validates_presence_of :movie, :description, :year, :director, :actors, :filming_locations, :countries

  self.per_page = 10
end
