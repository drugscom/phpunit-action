#!/bin/sh
exec /usr/local/bin/phpunit \
  --printer 'mheap\GithubActionsReporter\Printer' \
  "${@}"
