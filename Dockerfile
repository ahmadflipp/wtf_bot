FROM 421990735784.dkr.ecr.us-east-1.amazonaws.com/flipp/ruby-base:3.0-buster

# Rails pre-requisites:
RUN apt-get update

ENV KAFKA_CLIENT_PRIVATE_KEY_AUTO_DECRYPT true

RUN mkdir /var/app
WORKDIR /var/app
COPY Gemfile /var/app/Gemfile
COPY Gemfile.lock /var/app/Gemfile.lock

COPY vendor/bundle/ /var/app/vendor/bundle
RUN bundle config path 'vendor/bundle'
RUN bundle install

ARG CONTAINER_BUILD_COMMIT
ENV CONTAINER_BUILD_COMMIT $CONTAINER_BUILD_COMMIT

COPY . /var/app/


EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]

