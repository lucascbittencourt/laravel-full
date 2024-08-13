#!/bin/sh

set -e

echo "Navigating to laravel directory"
cd /app

if ! [ -f ".env" ]; then
  echo "Creating .env from .env.example"
  cp .env.example .env
fi

echo "Installing composer dependencies"
composer install --no-interaction --no-progress --optimize-autoloader

echo "Installing npm dependencies"
npm install
npm cache clean --force

echo "Starting supervisord"
supervisord -n -c /usr/local/etc/supervisord.conf
