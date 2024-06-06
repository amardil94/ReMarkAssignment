class AddUniqueConstraintToReviews < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      ALTER TABLE reviews
        ADD CONSTRAINT movie_id_user_upsert UNIQUE (movie_id, "user");
    SQL
  end
  
  def down
    execute <<-SQL
      ALTER TABLE reviews
        DROP CONSTRAINT movie_id_user_upsert;
    SQL
  end
end
