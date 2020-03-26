class CreateMovieComments < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_comments do |t|
      t.integer :movie_id
      t.text :text
      t.integer :user
      t.integer :parent_id

      t.timestamps
    end
  end
end
