namespace :movie do
  desc "Updates movie image URLs from 185px wide to 300px wide"
  task update_image_width: :environment do
    Movie.all.each do |movie|
      movie[:image].gsub!(/w185/, 'w300')
      movie.update({ image: movie[:image] })
    end
  end

  desc "Strip whitespace from tags"
  task update_tags: :environment do
    Tag.all.each do |tag|
      tag[:text].gsub!(/\s+/, '')
      tag.update({ text: tag[:text] })
    end
  end

  desc "Refreshes movie images to use latest IDs"
  task update_image_urls: :environment do
    Movie.all.each do |movie|
      img = TMDB.find_movie(movie[:tmdb_id])
      movie.update({ image: img['poster_path'] })
    end
  end
end
