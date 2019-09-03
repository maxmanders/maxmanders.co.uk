FROM jekyll/jekyll

LABEL maintainer "Max Manders <max@maxmanders.co.uk>"

ENV BUNDLER_VERSION 2.0.1

RUN apk -v --update add \
      python \
      py-pip \
      groff \
      less \
      mailcap \
      && \
    pip install --upgrade awscli && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

