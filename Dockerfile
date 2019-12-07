FROM ruby:latest

WORKDIR /var/run/aoc

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD bash
