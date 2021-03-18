#!/bin/sh
set -o errexit

get_bootstrap() {
  while test "${#}" -gt "0"; do
    case "${1}" in
      --bootstrap)
        echo "${2}"
        return
      ;;
      --bootstrap=*)
        echo "${1}" | cut -d '=' -f '2-'
        return
      ;;
      *)
        shift
      ;;
    esac
  done
}

PHPUNIT_ADDITIONAL_BOOTSTRAP=$(get_bootstrap "${@}") \
/usr/local/bin/phpunit \
  --printer 'mheap\GithubActionsReporter\Printer' \
  "${@}" \
  --bootstrap '/usr/local/shared/phpunit/autoload.php'
