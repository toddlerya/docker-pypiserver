#!/bin/sh

PYPI_ROOT="${PYPI_ROOT:-/data}"
PYPI_PACKAGES="${PYPI_PACKAGES:-${PYPI_ROOT}/packages}"
PYPI_PORT=${PYPI_PORT:-8080}
PYPI_PASSWD_FILE="${PYPI_PASSWD_FILE:-${PYPI_ROOT}/.htpasswd}"
PYPI_AUTHENTICATE="${PYPI_AUTHENTICATE:-update}"

# make sure the passwd file exists
touch "${PYPI_PASSWD_FILE}"

_extra="${PYPI_EXTRA}"

# allow existing packages to be overwritten
if [[ "${PYPI_OVERWRITE}" != "" ]]; then
    _extra="${_extra} --overwrite"
fi

exec /usr/bin/pypi-server \
    --port ${PYPI_PORT} \
    --passwords "${PYPI_PASSWD_FILE}" \
    --authenticate "${PYPI_AUTHENTICATE}" \
    ${_extra} \
    "${PYPI_PACKAGES}"
