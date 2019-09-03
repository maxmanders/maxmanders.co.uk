FROM jekyll/jekyll

LABEL maintainer "Max Manders <max@maxmanders.co.uk>"

ENV BUNDLER_VERSION 2.0.1
ENV BUNDLE_CACHE=/vendor/cache

RUN mkdir -p ${BUNDLE_CACHE}
RUN chown -R jekyll:jekyll ${BUNDLE_CACHE}
COPY Gemfile* /tmp/
RUN chown -R jekyll:jekyll /tmp/Gemfile*
RUN chmod +w /tmp/Gemfile.lock
WORKDIR /tmp/
RUN bundle install --path=${BUNDLE_CACHE}

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

WORKDIR /srv/jekyll/
