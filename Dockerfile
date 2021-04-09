FROM ruby:2.5-alpine

RUN apk add --no-cache build-base libxml2-dev libxslt-dev sqlite-dev git nodejs bash && mkdir -p /app 
WORKDIR /app

COPY Gemfile* /


RUN bundle install --without development test --jobs 20 --retry 5
COPY . ./

EXPOSE 5000
CMD sleep 3600