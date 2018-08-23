FROM ruby:2.5.1-alpine

RUN apk add --no-cache git build-base

COPY Gemfile* content_integrator.gemspec /app/
COPY lib/content_integrator/version.rb /app/lib/content_integrator/version.rb

WORKDIR /app

RUN bundle install -j $(nproc)

COPY . /app

CMD [ "bundle", "exec", "irb" ]
