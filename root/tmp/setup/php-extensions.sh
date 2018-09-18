#!/usr/bin/env bash

set -e

echo "Installing apt dependencies"

# Build packages will be added during the build, but will be removed at the end.
BUILD_PACKAGES="gettext gnupg libcurl4-openssl-dev libfreetype6-dev libicu-dev libjpeg62-turbo-dev \
  libldap2-dev libmariadbclient-dev libmemcached-dev libpng-dev libpq-dev libxml2-dev libxslt-dev \
  unixodbc-dev zlib1g-dev"

# Packages for Postgres.
PACKAGES_POSTGRES="libpq5"

# Packages for MariaDB and MySQL.
PACKAGES_MYMARIA="libmariadbclient18"

# Packages for other Moodle runtime dependenices.
PACKAGES_RUNTIME="ghostscript libaio1 libcurl3 libgss3 libicu57 libmcrypt-dev libxml2 libxslt1.1 locales sassc unzip unixodbc"

# Packages for Memcached.
PACKAGES_MEMCACHED="libmemcached11 libmemcachedutil2"

# Packages for LDAP.
PACKAGES_LDAP="libldap-2.4-2"

apt-get update
apt-get install -y --no-install-recommends apt-transport-https \
    $BUILD_PACKAGES \
    $PACKAGES_POSTGRES \
    $PACKAGES_MYMARIA \
    $PACKAGES_RUNTIME \
    $PACKAGES_MEMCACHED \
    $PACKAGES_LDAP

# Generate the locales configuration fo rboth Australia, and the US.
echo 'Generating locales..'
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'en_AU.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

echo "Installing php extensions"
docker-php-ext-install -j$(nproc) \
    intl \
    mysqli \
    opcache \
    pgsql \
    soap \
    xsl \
    xmlrpc \
    zip

# GD.
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
docker-php-ext-install -j$(nproc) gd

# LDAP.
docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
docker-php-ext-install -j$(nproc) ldap

# SOLR, Memcached, Redis, APCu, igbinary, and memcached.
pecl install solr memcache redis mongodb igbinary apcu-4.0.11 memcached-2.2.0
docker-php-ext-enable solr memcache memcached redis mongodb apcu igbinary

echo 'apc.enable_cli = On' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini

echo "Downloading freedts files"
curl http://www.freetds.org/files/stable/freetds-1.00.33.tar.gz -o /tmp/freetds-1.00.33.tar.gz

echo "Building mssql extension"
cd /tmp && tar -xvf freetds-1.00.33.tar.gz && cd freetds-1.00.33 \
    && ./configure --with-unixodbc=/usr --sysconfdir=/etc/freetds --enable-sybase-compat \
    && make -j$(nproc) \
    && make install

docker-php-ext-install -j$(nproc) mssql

# Keep our image size down..
pecl clear-cache
apt-get remove --purge -y $BUILD_PACKAGES
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
