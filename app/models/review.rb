class Review < ApplicationRecord
  belongs_to :movie
  validates_presence_of :user, :stars, :review
end
