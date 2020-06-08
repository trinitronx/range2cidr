#!/usr/bin/env sh

set -e # Drop-out from execution if error occurs

aclocal && autoconf && automake -a --add-missing

printf '\nSuccess!\nNow please run: ./autogen.sh\n'