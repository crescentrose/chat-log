FROM ruby:3.1.2-alpine

WORKDIR /app

RUN apk -U add postgresql-client build-base

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

RUN bundle exec rails assets:precompile

EXPOSE 3000 27115

CMD ["bin/migrate_and_run"]
