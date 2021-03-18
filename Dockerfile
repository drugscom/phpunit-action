FROM docker.io/library/alpine:3.13

LABEL 'com.github.actions.name'='PHPUnit unit testing'
LABEL 'com.github.actions.description'='PHP unit testing using PHPUnit'

RUN apk --no-cache add \
    php7=~7.4 \
    php7-ctype=~7.4 \
    php7-curl=~7.4 \
    php7-dom=~7.4 \
    php7-fileinfo=~7.4 \
    php7-intl=~7.4 \
    php7-json=~7.4 \
    php7-mysqli=~7.4 \
    php7-pdo=~7.4 \
    php7-phar=~7.4 \
    php7-session=~7.4 \
    php7-simplexml=~7.4 \
    php7-sockets=~7.4 \
    php7-tokenizer=~7.4 \
    php7-xml=~7.4 \
    php7-xmlwriter=~7.4

RUN wget -q -O /usr/local/bin/phpunit 'https://phar.phpunit.de/phpunit-9.5.phar' \
    && chmod +x /usr/local/bin/phpunit

COPY autoload.php /usr/local/shared/phpunit/autoload.php
COPY Printers/phpunit-github-actions-printer/src /usr/local/shared/phpunit/Printers/mheap/GithubActionsReporter

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

RUN mkdir /app
WORKDIR /app
