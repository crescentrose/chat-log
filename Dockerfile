FROM ruby:3.0.2

WORKDIR /app

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs postgresql-client && \
  npm install -g yarn

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install && yarn install

COPY . /app

EXPOSE 3000
CMD ["bin/migrate_and_run"]
