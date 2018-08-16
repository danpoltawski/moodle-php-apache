# moodle-php-apache: A Moodle PHP Environment

A Moodle PHP environment configured for Moodle development based on [Official PHP Images](https://hub.docker.com/_/php/).

### Versions

| PHP Version  | Tag | Status |
|--------------|-----|--------|
| PHP 7.1 | 7.1 | [![Build Status](https://travis-ci.org/moodlehq/moodle-php-apache.svg?branch=php71)](https://travis-ci.org/moodlehq/moodle-php-apache)|
| PHP 7.0 | 7.0 | [![Build Status](https://travis-ci.org/moodlehq/moodle-php-apache.svg?branch=php70)](https://travis-ci.org/moodlehq/moodle-php-apache)|
|PHP 5.6 | 5.6 | [![Build Status](https://travis-ci.org/moodlehq/moodle-php-apache.svg?branch=php56)](https://travis-ci.org/moodlehq/moodle-php-apache)|

# Example usage
The following command will expose the current working directory on port 8080:
```bash
$ docker run --name web0 -p 8080:80  -v $PWD:/var/www/html moodlehq/moodle-php-apache:7.1
```

# Features

* Preconfigured with all php extensions required for Moodle development and all database drivers
* Serves wwroot configured at /var/www/html/
* Verified by [automated tests](https://travis-ci.org/moodlehq/moodle-php-apache)

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
