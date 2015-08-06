FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq vim supervisor curl apache2 \
    libapache2-mod-php5 php5-gd php-pear php5-curl php5-mcrypt php5-memcache php5-xdebug php5-dev libpcre3-dev  libapache2-mod-auth-mysql php5-mysql
RUN a2enmod php5
RUN a2enmod ssl
RUN a2enmod rewrite
EXPOSE 80 443
WORKDIR /var/www

# Konfiguration
RUN usermod -u 1000 www-data && usermod -a -G users www-data

# Apache Konfiguration
ADD vhost.conf /etc/apache2/sites-enabled/000-default.conf

#PHP User Configuration
RUN echo "date.timezone=\"Europe/Berlin\" \nxdebug.max_nesting_level=250" > /etc/php5/apache2/conf.d/30-user.ini
RUN echo "display_errors=1" >> /etc/php5/apache2/conf.d/30-user.ini
RUN echo "ServerName localhost" > /etc/apache2/conf-available/user.conf && a2enconf user

# Supervisord Konfiguration
ADD supervisord.conf /etc/supervisor/supervisord.conf
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
