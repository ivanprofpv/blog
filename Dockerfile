FROM ruby:3.1.2-alpine3.15

RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

RUN mkdir /blog
WORKDIR /blog
ADD Gemfile /blog/Gemfile
RUN bundle install
ADD . /blog

CMD ["rails", "db:seed"]
