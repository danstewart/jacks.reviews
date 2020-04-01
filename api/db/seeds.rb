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
      title: Faker::Pokemon.name,
      tmdb_id: Faker::Number.between(from: 0, to: 50000),
      rating: ['A+', 'A', 'A-', 'B+', 'B' ].sample,
      review: Faker::Lorem.paragraph,
      image: [
        'https://image.tmdb.org/t/p/w300/hEpWvX6Bp79eLxY1kX5ZZJcme5U.jpg',
        'https://image.tmdb.org/t/p/w300/140ewbWv8qHStD3mlBDvvGd0Zvu.jpg',
        'https://image.tmdb.org/t/p/w300/1AreNcL9s24Qfghbzomy0IlzCFk.jpg',
        'https://image.tmdb.org/t/p/w300/93Y9BGx8blzmZOPSoivkFfaifqU.jpg'
      ].sample
    )

    # Add tags to movie
    movie_tags = MovieTag.create(movie_id: movie[:id], tag_id: [1,2,3].sample(rand 2))
  end

  20.times do
    MovieComment.create(
      movie_id: rand(movie_count),
      text: Faker::PrincessBride.quote,
      user: rand(2),
    )
  end
end
