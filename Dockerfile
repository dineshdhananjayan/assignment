FROM ubuntu:18.04
MAINTAINER dinesh dhananjayan
# System requirements
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
apache2 \
software-properties-common
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && apt-get install -y tzdata

#RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8

RUN add-apt-repository  ppa:ondrej/php  -y \
&& apt-get update
#add-apt-repository ppa:ondrej/php \

RUN apt-get install -y --no-install-recommends \
php7.1 \
libapache2-mod-php7.1 \
php7.1-mcrypt \
php7.1-mysql \
php7.1-curl \
curl \
git \
&& rm -rf /var/lib/apt/lists/*

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www


ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR
RUN mkdir -p $APACHE_LOCK_DIR
RUN mkdir -p $APACHE_LOG_DIR



CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]

EXPOSE 80

