FROM ruby:3.0.3

ENV DATABASE_HOST=db
ENV REDIS_URL=redis://redis:6379/0
ENV REDIS_HOST=redis

RUN mkdir /app
WORKDIR /app

EXPOSE 3000

COPY Gemfile .
COPY Gemfile.lock .
RUN gem update bundler
RUN bundle install
