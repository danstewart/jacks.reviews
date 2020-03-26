class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :tmdb_id
      t.string :rating
      t.string :image
      t.text :review
      t.integer :added_by

      t.timestamps
    end
  end
end
