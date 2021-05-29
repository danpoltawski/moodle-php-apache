# moodle-php-apache: A Moodle PHP Environment

A Moodle PHP environment configured for Moodle development based on [Official PHP Images](https://hub.docker.com/_/php/).

### Versions

| PHP Version  | Variant | Tags             | Status | Notes |
|--------------|---------|------------------|--------|-------|
| PHP 8.0      | Buster  | 8.0, 8.0-buster  | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=8.0-buster)](https://travis-ci.com/moodlehq/moodle-php-apache)|
| PHP 7.4      | Buster  | 7.4, 7.4-buster  | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.4-buster)](https://travis-ci.com/moodlehq/moodle-php-apache)|
| PHP 7.3      | Buster  | 7.3, 7.3-buster  | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.3-buster)](https://travis-ci.com/moodlehq/moodle-php-apache)|
| PHP 7.2      | Buster  | 7.2, 7.2-buster  | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.2-buster)](https://travis-ci.com/moodlehq/moodle-php-apache)|PHP 7.2 EOL|
| PHP 7.1      | Buster  | 7.1, 7.1-buster  | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.1-buster)](https://travis-ci.com/moodlehq/moodle-php-apache)|PHP 7.1 EOL|
| PHP 7.3      | Stretch | 7.3-stretch      | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.3-stretch)](https://travis-ci.com/moodlehq/moodle-php-apache)|Stretch EOL|
| PHP 7.2      | Stretch | 7.2-stretch      | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.2-stretch)](https://travis-ci.com/moodlehq/moodle-php-apache)|Stretch and PHP 7.2 EOL|
| PHP 7.1      | Stretch | 7.1-stretch      | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.1-stretch)](https://travis-ci.com/moodlehq/moodle-php-apache)|Stretch and PHP 7.1 EOL|
| PHP 7.0      | Stretch | 7.0, 7.0-stretch | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.0-stretch)](https://travis-ci.com/moodlehq/moodle-php-apache)|Stretch and PHP 7.0 EOL|
| PHP 5.6      | Stretch | 5.6, 5.6-stretch | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=5.6-stretch)](https://travis-ci.com/moodlehq/moodle-php-apache)|Stretch and PHP 5.6 EOL|
| PHP 7.1      | Jessie  | 7.1-jessie       | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.1-jessie)](https://travis-ci.com/moodlehq/moodle-php-apache)|Jessie and PHP 7.1 EOL|
| PHP 7.0      | Jessie  | 7.0-jessie       | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=7.0-jessie)](https://travis-ci.com/moodlehq/moodle-php-apache)|Jessie and PHP 7.0 EOL|
| PHP 5.6      | Jessie  | 5.6-jessie       | [![Build Status](https://travis-ci.com/moodlehq/moodle-php-apache.svg?branch=5.6-jessie)](https://travis-ci.com/moodlehq/moodle-php-apache)|Jessie and PHP 5.6 EOL|

# Example usage
The following command will expose the current working directory on port 8080:
```bash
$ docker run --name web0 -p 8080:80  -v $PWD:/var/www/html moodlehq/moodle-php-apache:7.1
```

# Features

* Preconfigured with all php extensions required for Moodle development and all database drivers
* Serves wwroot configured at /var/www/html/
* Verified by [automated tests](https://travis-ci.com/moodlehq/moodle-php-apache)

# Directories

To faciliate testing and easy setup the following directories are created and owned by www-data by default:
* `/var/www/moodledata`
* `/var/www/phpunitdata`
* `/var/www/behatdata`
* `/var/www/behatfaildumps`

# Xdebug

For development, the image contains the Xdebug PHP extension. This is disabled by default, for performance reasons, but can be enabled by setting a non-empty XDEBUG_CONFIG environment variable. This environment variable is also used by Xdebug for configuration (see [XDebug documentation](https://xdebug.org/docs) for details and available configuration settings).

```bash
$ docker run --name web0 -p 8080:80  -v $PWD:/var/www/html -e XDEBUG_CONFIG="remote_enable=1 remote_connect_back=1" moodlehq/moodle-php-apache:7.1
```

# See also
This container is part of a set of containers for Moodle development, see also:
* [moodle-docker](https://github.com/moodlehq/moodle-docker) a docker-composer based set of tools to get Moodle development running with zero configuration
* [moodle-db-mssql](https://github.com/moodlehq/moodle-db-mssql) Microsoft SQL Server for Linux configured for Moodle development
* [moodle-db-oracle](https://github.com/moodlehq/moodle-db-oracle) Oracle XE configured for Moodle development
