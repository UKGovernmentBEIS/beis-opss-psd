FROM ruby:2.7.2

RUN gem install bundler:2.2.20

WORKDIR /psd

COPY ./docker/worker/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
