# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Movie.destroy_all
User.destroy_all

#=================#
# PRODUCTION DATA #
#=================#

# Insert default users
user = User.create(
  name: 'Dan',
  email: 'danielandrewstewart@gmail.com',
)
user = User.create(
  name: 'Jack',
  email: 'jack.mclean.97@hotmail.com',
)

#==================#
# DEVELOPMENT DATA #
#==================#
if Rails.env.development?
  # Create default tags
  %w{Funny Action Classic}.each { |tag| Tag.create(text: tag) }

  # Dummy movies
  movie_count = 10
  movie_count.times do
    movie = Movie.create(
      title: Faker::Games::Pokemon.name,
      tmdb_id: Faker::Number.between(from: 0, to: 50000),
      rating: ['A+', 'A', 'A-', 'B+', 'B' ].sample,
      review: Faker::Lorem.paragraph,
      image: [
        'https://image.tmdb.org/t/p/w300/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg',
        'https://image.tmdb.org/t/p/w300/yHA9Fc37VmpUA5UncTxxo3rTGVA.jpg',
        'https://image.tmdb.org/t/p/w300/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg',
      ].sample
    )

    # Add tags to movie
    movie_tags = MovieTag.create(movie_id: movie[:id], tag_id: [1,2,3].sample,
  end

  20.times do
    MovieComment.create(
      movie_id: rand(movie_count),
      text: Faker::Movies::PrincessBride.quote,
      user: rand(2),
    )
  end
end
