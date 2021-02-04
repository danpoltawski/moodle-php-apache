#!/usr/bin/env bash

set -e

usage() { echo "Usage: $0 -d <debug> -v <Xdebug version> -p <port> -h <remote host>" 1>&2; exit 1; }

while getopts ":d:v:p:h:" o; do
    case "${o}" in
        d)
            DEBUG=${OPTARG}
            ;;
        v)
            VERSION=${OPTARG}
            ;;
        p)
            PORT=${OPTARG}
            ;;
        h)
            REMOTE_HOST=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift "$((OPTIND-1))"

echo $DEBUG
echo $VERSION
echo $PORT
echo $REMOTE_HOST


if [[ -z $DEBUG ]] || [[ -z $VERSION ]] || [[ -z $PORT ]] || [[ -z $REMOTE_HOST ]]; then 
    usage 
fi

if [ $DEBUG == 1 ]; then
  
    XDEBUG_INI_FILE=/usr/local/etc/php/conf.d/xdebug.ini

    # Install Xdebug
    echo "Installing Xdebug"
    pecl install xdebug-$VERSION
    docker-php-ext-enable xdebug

    # Adding Xdebug log file
    mkdir /var/log/xdebug
    touch /var/log/xdebug/xdebug.log
    chmod 777 /var/log/xdebug/xdebug.log

    # Adding Xdebug INI file
    cat <<EOF >> $XDEBUG_INI_FILE
    zend_extension=xdebug.so
    xdebug.remote_enable=1
    xdebug.remote_handler=dbgp
    xdebug.remote_mode=req
    xdebug.remote_host=$REMOTE_HOST
    xdebug.remote_port=$PORT
    xdebug.remote_log=/var/log/xdebug/xdebug.log
EOF
fi