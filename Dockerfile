FROM ruby:3.2.1-alpine

WORKDIR /app

RUN apk -U add postgresql-client postgresql-dev build-base nodejs tzdata libxslt-dev libxml2-dev imagemagick

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

RUN bundle exec rails assets:precompile

EXPOSE 3000 27115

CMD ["bin/migrate_and_run"]
