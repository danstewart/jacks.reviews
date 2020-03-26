module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredToken < StandardError; end
  class EmailFailure < StandardError; end
  class TMDBFailure < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredToken, with: :four_twenty_two
    rescue_from ExceptionHandler::EmailFailure, with: :five_hundred
    rescue_from ExceptionHandler::TMDBFailure, with: :five_hundred

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end


  private
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def five_hundred(e)
    json_response({ message: e.message }, :internal_server_error)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end