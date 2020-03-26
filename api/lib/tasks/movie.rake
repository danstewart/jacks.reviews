namespace :movie do
  desc "Updates movie image URLs from 185px wide to 300px wide"
  task update_urls: :environment do
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
end
