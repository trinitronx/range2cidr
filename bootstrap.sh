#!/usr/bin/env sh
BOOTSTRAP_DIR=$(cd $(dirname $0) && pwd)

set -e # Drop-out from execution if error occurs

. $BOOTSTRAP_DIR/autogen.sh

aclocal && autoconf && automake -a --add-missing

