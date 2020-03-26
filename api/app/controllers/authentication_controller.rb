class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:name]).call
    base_url   = Rails.env.development? ? 'http://127.0.0.1:8080' : 'https://jacks.reviews'

    # Send user a login token
    from    = 'noreply@jacks.reviews'
    to      = auth_params[:email]
    subject = 'Login for Jacks Reviews'
    url     = "#{base_url}/#/authenticate?token=#{auth_token}"

    Email.send(from, to, subject, Message.login_email_html(url), Message.login_email_text(url))
    head :no_content
  end

  private
  def auth_params
    params.permit(:email, :name)
  end
end
