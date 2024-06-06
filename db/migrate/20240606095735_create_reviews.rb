class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.bigint :movie_id, index: true
      t.string :user
      t.integer :stars
      t.string :review
      
      t.timestamps
    end
  end
end
