FROM ubuntu

MAINTAINER jkgeyti

RUN apt-get update

RUN apt-get -y install git python build-essential g++ flex bison gperf ruby perl \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev && \
  cd /opt && \
  git clone git://github.com/ariya/phantomjs.git && \
  cd phantomjs && \
  git checkout 2.0 && \  
  ./build.sh --confirm && \
  ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs  

RUN cd /opt && \
  git clone git://github.com/n1k0/casperjs.git && \
  ln -s /opt/casperjs/bin/casperjs /usr/local/bin/casperjs

RUN apt-get uninstall -y git python build-essential g++ flex bison gperf ruby perl \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Default command
ENTRYPOINT "phantomjs"
CMD ["--help"]