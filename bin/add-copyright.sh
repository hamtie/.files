#!/usr/bin/env bash
#
# Usage ./add-copyright.sh <company-name>
#
set -e

if [ -z "$1" ]
  then
    echo "Company name not provided"
    exit 1
fi

COMPANY=$1
COPYRIGHT="// (c) Copyright $COMPANY, Inc.\n// All Rights Reserved.\n"

IGNORE_DIRS=('./tmp/*' './db/*' './target/*' './*.log' './.*')

CMD="find . -type f $(printf "! -path \"%s\" " "${IGNORE_DIRS[@]}") -exec sed -i '1 a $COPYRIGHT' {} \;"

echo -e "Running:"
echo -e $CMD
eval $CMD

exit 0

