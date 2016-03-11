FROM pimterry/node-karma
MAINTAINER Flávio Ribeiro <email@flavioribeiro.com>

#================================================
# Customize sources for apt-get
#================================================
RUN echo "deb http://archive.ubuntu.com/ubuntu vivid main universe" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu vivid-updates main universe" >> /etc/apt/sources.list

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get update -y \
 && apt-get -y --no-install-recommends install \
    ca-certificates \
    openjdk-8-jre-headless \
    libxi6 \
    libgconf-2-4 \
    sudo \
    unzip \
    wget \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

RUN apt-get install -y rubygems-integration inotify-tools
RUN gem install sass -v 3.3.14

#==========
# Selenium
#==========
RUN mkdir -p /opt/selenium
RUN wget --no-verbose http://selenium-release.storage.googleapis.com/2.48/selenium-server-standalone-2.48.2.jar -O /opt/selenium/selenium-server-standalone.jar

#===================================
# Download the latest Chrome driver
#===================================
ENV CHROME_DRIVER_VERSION 2.20
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
 && rm -rf /opt/selenium/chromedriver \
 && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
 && rm /tmp/chromedriver_linux64.zip \
 && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
 && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
 && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

EXPOSE 4444
