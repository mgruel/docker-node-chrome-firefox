FROM buildpack-deps:jessie-curl

# Install node 5.x
RUN set -x \
    && curl -sL https://deb.nodesource.com/setup_5.x | bash - \
    && apt-get install -y \
        nodejs \
    && npm install -g npm@latest

# Install Java 8

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        locales

ENV LANG C.UTF-8
RUN locale-gen $LANG

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install Chrome
RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
        chromium

ADD scripts/xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

# Install firefox
RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
        iceweasel

ADD scripts/xvfb-firefox /usr/bin/xvfb-firefox
RUN ln -sf /usr/bin/xvfb-firefox /usr/bin/firefox

# RUN node -v
# RUN npm -v
# RUN java -version
# RUN apt-cache policy iceweasel | grep Installed | sed -e "s/Installed/Firefox/"
# RUN apt-cache policy chromium | grep Installed | sed -e "s/Installed/Chrome/"

WORKDIR /usr/src/app

ONBUILD COPY .npmrc /usr/src/app/.npmrc
ONBUILD COPY package.json /usr/src/app/package.json
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app
