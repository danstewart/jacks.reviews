SES_ACCESS = ApiJacksReviews::Application.credentials.aws[:ses][:access]
SES_SECRET = ApiJacksReviews::Application.credentials.aws[:ses][:secret]

Aws.config.update(
  credentials: Aws::Credentials.new(SES_ACCESS, SES_SECRET),
  region: 'eu-west-1'
)