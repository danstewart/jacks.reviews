# Generates a JWT for a user if their email exists in the DB (ie. Logs them in)
class AuthenticateUser
  def initialize(email, name)
    @email = email
    @name = name
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private
  attr_reader :email, :user

  def user
    user = User.find_by(email: email)
    return user if user

    raise(ExceptionHandler::AuthenticationError, Message.invalid_email)
  end

end