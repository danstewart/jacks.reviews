module TMDB

  ENDPOINT = 'api.themoviedb.org'.freeze

  def self.find_movie(id)
    uri = URI::HTTPS.build(host: ENDPOINT, path: "/3/movie/#{id}", query: query)
    details = parse_response(HTTP.get(uri))

    # Set the full poster path
    # TODO: Use URI
    if details['poster_path']
      poster_size = 'w300'
      details['poster_path'] = [get_config['images']['secure_base_url'], poster_size, details['poster_path']].join
    end

    return details
  end

  def self.search_movies(search)
    uri = URI::HTTPS.build(host: ENDPOINT, path: '/3/search/movie', query: query(query: search))
    res = parse_response(HTTP.get(uri))

    results = res['results'] if res.key?('results')

    return results
  end

  # private

  # Parses the API responses and handles errors
  def self.parse_response(res)
    if res.status.success? && !res.body.blank?
      return JSON.parse(res.body)
    end

    error = "Error making request to TMDB.\nStatus: #{res.status.code}\nMessage: #{res.body}"
    STDERR.puts error
    raise ExceptionHandler::EmailFailure, error
  end

  # Fetches and caches API config
  def self.get_config
    # Fetch from cache if out cache has been updated in the last 2 days
    config = Cache.fetch(:tmdb_config, 172_800)

    # Otherwise make a new API request and cache the response
    if config.blank?
      uri = URI::HTTPS.build(host: ENDPOINT, path: '/3/configuration', query: query)
      config = parse_response(HTTP.get(uri))
      Cache.store(:tmdb_config, config)
    end

    return config
  end

  # Builds query string
  def self.query(other_params = {})
    key = ApiJacksReviews::Application.credentials.tmdb_api_key
    return { api_key: key }.merge(other_params).to_query
  end

  # Set private methods
  private_class_method :parse_response
  private_class_method :get_config
  private_class_method :query
end
