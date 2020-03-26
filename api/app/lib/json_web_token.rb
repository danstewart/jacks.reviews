class JsonWebToken
  APP_SECRET = ApiJacksReviews::Application.credentials.secret_key_base

  def self.encode(payload, exp = 1.month.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, APP_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, APP_SECRET)[0]
    HashWithIndifferentAccess.new body

  rescue JWT::ExpiredSignature
    raise ExceptionHandler::ExpiredToken, Message.expired_token

  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, Message.invalid_token
  end
end