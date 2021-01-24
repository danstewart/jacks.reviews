FROM ruby:2.7.0-slim-buster

LABEL Author="Daniel Stewart"
LABEL E-mail="danielandrewstewart@gmail.com"
LABEL version="0.0.1"

# Set the env vars
ARG RAILS_ENV
ARG MYSQL_ROOT_PASWORD
ENV RAILS_ENV $RAILS_ENV
ENV MYSQL_ROOT_PASWORD $MYSQL_ROOT_PASWORD

# Update and install deps
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev libssl-dev default-libmysqlclient-dev vim

# Create user and directory
RUN useradd --create-home code
USER code
RUN mkdir -p /home/code/jacks.reviews
WORKDIR /home/code/jacks.reviews

# Copy Gemfile and install ruby deps
COPY --chown=code:code Gemfile Gemfile.lock ./
RUN bundler

# Copy the rest of the code
COPY --chown=code:code . ./
# Have to copy this separately for some reason
COPY --chown=code:code ./config/master.key ./config/

# Start
EXPOSE 3000
# CMD ls
CMD bundle exec unicorn_rails -c ./config/unicorn.rb -p 3000

