class Message
  def self.not_found(record = 'Movie')
    "#{record} not found."
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.expired_token
    'Expired token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.expired_token
    'Expired token'
  end

  def self.invalid_email
    'Invalid email'
  end

  def self.login_email_html(url)
    # TODO: Improve the design of this email
    '<h2>Login email for Jacks Reviews</h2>' \
    "<br><p>Simply click <a href='#{url}'>here</a> to login.</p>"
  end

  def self.login_email_text(url)
    "Login email for Jacks Reviews\n\nSimply click the below link to login:\n\n#{url}"
  end
end
