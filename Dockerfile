FROM pimterry/node-karma-selenium
MAINTAINER Flávio Ribeiro <email@flavioribeiro.com>

# Install ruby and sass

RUN apt-get update
RUN apt-get install -y rubygems-integration inotify-tools
RUN gem install sass -v 3.3.14

