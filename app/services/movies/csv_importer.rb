require 'csv'

module Movies
  class CsvImporter
    def self.run(directory, log_failed = true)
      has_error = false
      return "Unable to find movies.csv" unless File.file?("#{directory}/movies.csv")

      return "Unable to find reviews.csv" unless File.file?("#{directory}/reviews.csv")
      
      movie_hash = {}
      review_hash = {}

      movie_objects = []
      review_objects = []

      CSV.foreach("#{directory}/movies.csv", :headers => true) do |row|
        if row['Movie'].nil?
          has_error = true
          next
        end
        movie_name = row['Movie']

        if movie_hash.key?(movie_name)
          movie_hash[movie_name][:actors].push(row['Actor']) unless movie_hash[movie_name][:actors].include?(row['Actor'])
          movie_hash[movie_name][:filming_locations].push(row['Filming location']) unless movie_hash[movie_name][:filming_locations].include?(row['Filming location'])
          movie_hash[movie_name][:countries].push(row['Country']) unless movie_hash[movie_name][:countries].include?(row['Country'])
        else
          movie_hash[movie_name] = { description: row['Description'], year: row['Year'], director: row['Director'], actors: [row['Actor']], filming_locations: [row['Filming location']], countries: [row['Country']] }
        end
      end

      CSV.foreach("#{directory}/reviews.csv", :headers => true) do |row|
        if row['Movie'].nil?
          has_error = true
          next
        end
        movie_name = row['Movie']

        if review_hash.key?(movie_name)
          review_hash[movie_name].push({ user: row['User'], stars: row['Stars'], review: row['Review'] })
        else
          review_hash[movie_name] = [{ user: row['User'], stars: row['Stars'], review: row['Review'] }]
        end
      end

      movie_hash.each do |title, data|
        data[:movie] = title
        movie_obj = Movie.new(data)
        movie_objects.push(movie_obj)
        review_hash[title].each do |review|
          review_obj = Review.new(review)
          review_obj.movie = movie_obj
          review_objects.push(review_obj)
        end
      end

      movie_result = Movie.import(movie_objects, validate: true, on_duplicate_key_update: { conflict_target: [:movie], columns: [:actors, :filming_locations, :countries] })
      review_result = Review.import(review_objects, validate: true, on_duplicate_key_update: { constraint_name: :movie_id_user_upsert, columns: [:stars, :review] })

      if movie_result.failed_instances.length > 0
        Logger.new("#{Rails.root}/log/failed_imports.log").error("Failed movie records: #{movie_result.failed_instances}") if log_failed
        has_error = true
      end

      if review_result.failed_instances.length > 0
        Logger.new("#{Rails.root}/log/failed_imports.log").error("Failed review records: #{review_result.failed_instances}") if log_failed
        has_error = true
      end
      
      has_error ? 'Import completed, but some records failed to import.' : 'Import completed successfully' 
    end
  end
end