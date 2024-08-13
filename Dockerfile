FROM dunglas/frankenphp:php8.3-alpine

LABEL maintainer="Lucas Bittencourt <lucascbittencourt1@gmail.com>"

# Host user
ARG UID=1000
ARG GID=1000
ARG USER=app
ARG GROUP=app

# Install PHP Extensions
RUN install-php-extensions \
    @composer \
    pcntl \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache \
    redis \
    xdebug

# Install additional packages
RUN apk update && apk upgrade --no-cache && \
    apk add --no-cache --update \
    supervisor \
    openssh-client \
    curl \
    git \
    nodejs \
    npm

# Add group and user app
RUN addgroup -S -g $GID $GROUP && \
    adduser -u $UID -G $GROUP -D $USER

ADD . /app

RUN chown -R $USER:$GROUP /app && \
    chmod -R 755 /app

WORKDIR /app
