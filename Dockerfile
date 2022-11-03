FROM ruby:2.6.7

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /chatsystem

WORKDIR /chatsystem

ADD Gemfile /chatsystem/Gemfile
ADD Gemfile.lock /chatsystem/Gemfile.lock

RUN bundle install

ADD . /chatsystem