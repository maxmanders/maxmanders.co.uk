FROM ruby:2.3.3
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && apt-get update -qq \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && apt-get install -y oracle-java8-installer \
       oracle-java8-set-default \
       build-essential \
       nodejs

ENV CI_PROJECT_DIR /builds/maxmanders/maxmanders.co.uk
ENV CI_CACHE_DIR /builds/maxmanders/maxmanders.co.uk/vendor
RUN mkdir -p $CI_PROJECT_DIR $CI_CACHE_DIR
WORKDIR $CI_PROJECT_DIR

ADD Gemfile* $CI_PROJECT_DIR/
RUN bundle install --path $CI_CACHE_DIR

ADD . $CI_PROJECT_DIR
