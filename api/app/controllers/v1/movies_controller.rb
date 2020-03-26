module V1
  class MoviesController < ApplicationController
    skip_before_action :authorize_request, only: %i[index by_tag show]
    before_action :set_movie, only: %i[show update destroy]

    # Handle missing params
    rescue_from ActionController::ParameterMissing do |error|
      json_response({ message: error }, :unprocessable_entity)
    end

    # GET /movies
    def index
      @movies = Movie.with(%w{tags comments})
      json_response(@movies.reverse)
    end

    # GET /movies/:id
    def show
      json_response(@movie.with(%w{tags}))
    end

    # POST /movies
    def create
      movie = movie_params || return

      # Fetch image URL from TMDB
      movie[:image] = TMDB.find_movie(movie[:tmdb_id])['poster_path']

      # Attach current user to review
      movie[:added_by] = @current_user.id

      # Add the record
      tags = movie.delete(:tags)
      @movie = Movie.create!(movie)

      # Add each tag
      tags.each { |tag| @movie.add_tag(tag) }

      json_response(@movie, :created)
    end

    # PUT /movies/:id
    def update
      movie = movie_params || return

      if (movie[:tmdb_id] != @movie[:tmdb_id])
        movie[:image] = TMDB.find_movie(movie[:tmdb_id])['poster_path']
      end

      # Clear and re-add tags
      MovieTag.where(movie_id: @movie.id).destroy_all
      tags = movie.delete(:tags)
      tags.each { |tag| @movie.add_tag(tag) }

      @movie.update(movie)
      head :no_content
    end

    # DELETE /movies/:id
    def destroy
      @movie.destroy
      head :no_content
    end

    # GET /movies/dropdown
    def dropdown
      results = TMDB.search_movies(search_params[:title])

      results.map! do |item|
        { id: item['id'], title: item['title'], year: item['release_date'][0..3] }
      end

      json_response(results)
    end

    private

    def movie_params
      params.require(:title)
      params.require(:tmdb_id)
      params.permit(:id, :title, :tmdb_id, :rating, :review, :tags => [])
    end

    def search_params
      params.permit(:title)
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end
  end
end
