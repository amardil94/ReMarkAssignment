class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :movie, index: { unique: true }
      t.string :description
      t.string :year
      t.string :director
      t.string :actors, array: true, index: true
      t.string :filming_locations, array: true, index: true
      t.string :countries, array: true, index: true

      t.timestamps
    end
  end
end
