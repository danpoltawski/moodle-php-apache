#!/usr/bin/env bash

set -e

echo "Installing Moodle Python mlbackend"

apt-get update
apt-get install -y --no-install-recommends python2.7 python-pip
pip install --no-cache-dir moodlemlbackend

# Keep our image size down.
rm -rf ~/.cache/pip
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
